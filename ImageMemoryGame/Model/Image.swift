//
//  Image.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 26/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

enum JSONSerializer {
    case missingKey
    case invalid
}

struct Image {
    let title: String
    let link: String
    let imageUrl: URL
}

extension Image {
    
    init?(json: [String: Any]) {
        
        guard let title = json["title"] as? String,
              let link = json["link"] as? String,
            let media = json["media"] as? [String: Any] else {
                return nil
        }
        
        guard let url = media["m"] as? String else {
            return nil
        }
        
        self.title = title
        self.link = link
        self.imageUrl = URL(string: url)!
    }
}
