//
//  MemoryGameViewController.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 26/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit
import Kingfisher

class MemoryGameViewController: UIViewController, MemorygameDataProvider {

    @IBOutlet weak var memoryGuessImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemCount = 9
    var viewModel: MemoryGameViewModel!
    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Memory Game"
        memoryGuessImageView.backgroundColor = UIColor.red
        
        //Configure CollectionView
        configureCollectionView()
        
        viewModel = MemoryGameViewModel()
        viewModel.delegate = self
        viewModel.loadImages()
    }

    //MARK: Configure CollectionViewCell
    private func configureCollectionView() {
       
        let padding: CGFloat = 5
        let height: CGFloat = (view.frame.size.width - padding) / 3 - padding
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: height, height: height)
    }
    
    //MARK: MemorygameDataProvider
    func didReceiveData(with images: [Image]) {
        guard images.count > 0 else {
            return
        }
        
        self.images = images
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didReceiveError(with message: String) {
        print(message)
    }
}

extension MemoryGameViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard images.count > 0 else {
            return 0
        }
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! ImageCell
        let image = images[indexPath.row]
        cell.posterImageView.kf.setImage(with: image.imageUrl, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        return cell
    }
}

extension MemoryGameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected: \(indexPath.row)")
    }
}
