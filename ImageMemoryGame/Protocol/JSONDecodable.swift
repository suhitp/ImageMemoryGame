//
//  JSONDecodable.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 26/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]

protocol JSONDecodable {
    init?(json: JSONDictionary)
}

func decode<T: JSONDecodable>(_ dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.flatMap { T(json: $0) }
}

func decode<T: JSONDecodable>(_ dictionary: JSONDictionary) -> T? {
    return T(json: dictionary)
}

func decode<T:JSONDecodable>(_ data: Data) -> [T]? {
    
    do {
        guard let JSONObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [JSONDictionary] else {
            return nil
        }
        return decode(JSONObject)
        
    } catch {
        return nil
    }
    
}
