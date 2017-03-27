//
//  MemoryGameViewModel.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 26/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

final class MemoryGameViewModel {
    
    weak var delegate: MemorygameDataProvider?
    
    func loadImages() {
        
        FlickrAPIClient.getImages { (images, error) in
            
            if let error = error  {
                self.delegate?.didReceiveError(with: error.localizedDescription)
                return
            }
            
            if let images = images {
                self.delegate?.didReceiveData(with: images)
            } else {
                self.delegate?.didReceiveData(with: [])
            }
        }
    }
}


