//
//  MemoryGameDataProvider.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 27/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

protocol MemorygameDataProvider: class {
    func didReceiveData(with images: [Image])
    func didReceiveError(with message: String)
}
