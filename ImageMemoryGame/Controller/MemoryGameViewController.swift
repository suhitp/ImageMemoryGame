//
//  MemoryGameViewController.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 26/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

class MemoryGameViewController: UIViewController {

    @IBOutlet weak var memoryGuessImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MemoryGameViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Memory Game"
        
        //Configure CollectionView
        configureCollectionView()
        
        viewModel = MemoryGameViewModel()
        memoryGuessImageView.backgroundColor = UIColor.red
    }

    //MARK: Configure CollectionViewCell
    private func configureCollectionView() {
       
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let height = (view.frame.size.width - CGFloat(5)) / 3 - CGFloat(5)
        layout.itemSize = CGSize(width: height, height: height)
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
    }
}

extension MemoryGameViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath)
        imageCell.backgroundColor = UIColor.blue
        return imageCell
    }
}

extension MemoryGameViewController: UICollectionViewDelegate {
    
}
