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
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    
    let itemCount = 9
    var viewModel: MemoryGameViewModel!
    var images: [Image] = []
    
    var timer: Timer?
    var counter = 0
    var isGameStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Memory Game"
        
        //Configure CollectionView
        configureCollectionView()
        
        //init viewmodel and set delegate
        viewModel = MemoryGameViewModel()
        viewModel.delegate = self
        view.startLoadingIndicator()
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
            self.counterLabel.isHidden = false
            self.view.stopLoadingIndicator()
            self.collectionView.reloadData()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameViewController.updateCounter), userInfo: nil, repeats: true)
        }
    }
    
    func didReceiveError(with message: String) {
       let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       let errorAlert = UIAlertAction(title: "Try Again", style: .default) { (_) in
          self.viewModel.loadImages()
       }
       alertController.addAction(errorAlert)
       present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Timer
    func updateCounter() {
        counter += 1
        counterLabel.text = "\(counter)"
        if counter == 15 {
            let randomNumber = arc4random_uniform(9)
            let image = images[Int(randomNumber)]
            memoryGuessImageView.isHidden = false
            memoryGuessImageView.kf.setImage(with: image.imageUrl)
            counterLabel.isHidden = true
            isGameStarted = true
            InfoLabel.isHidden = false
            collectionView.reloadData()
            timer?.invalidate()
            timer = nil
            counter = 0
        }
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
        configureCell(cell)
        
        if !isGameStarted {
            let image = images[indexPath.row]
            cell.posterImageView.kf.setImage(with: image.imageUrl, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        }
       
        return cell
    }
    
    private func configureCell(_ cell: ImageCell) {
        if isGameStarted {
            cell.posterImageView.isHidden = true
            cell.background.isHidden = false
        } else {
            cell.posterImageView.isHidden = false
            cell.background.isHidden = true
        }
    }
    
}

extension MemoryGameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected: \(indexPath.row)")
        
        guard isGameStarted == true  else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        
        cell.posterImageView.isHidden = false
        UIView.transition(from: cell.background, to: cell.posterImageView, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
        
        if cell.posterImageView.image == memoryGuessImageView.image {
            isGameStarted = false
            displaySuccessAlert()
        }
        
    }
}


extension MemoryGameViewController {
    
    fileprivate func displaySuccessAlert() {
        
        let alertController = UIAlertController(title: "Congrats", message: "👏🏻 Your guess is correct 😀", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Play again", style: .default) { (_) in
            self.images = []
            self.collectionView.reloadData()
            self.viewModel.loadImages()
            self.memoryGuessImageView.image = nil
            self.counterLabel.isHidden = false
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

}
