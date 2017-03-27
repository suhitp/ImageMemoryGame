//
//  FlickrAPIClient.swift
//  ImageMemoryGame
//
//  Created by Suhit Patil on 26/03/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

struct FlickrAPIClient {

    public static func getImages(completion: @escaping ([Image]?, Error?) -> Void)  {
        
        let baseUrl = "https://api.flickr.com/services/feeds/photos_public.gne"
        let url = baseUrl.appending("?format=json&nojsoncallback=1")
        guard let requestUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
                
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, error)
                    return
                }
                
                guard let items = json["items"] as? [[String: Any]] else {
                    completion(nil, error)
                    return
                }
                
                let images = items.flatMap {
                    Image.init(json: $0)
                }
                completion(images, nil)
                
            } catch {
                completion(nil, error)
            }
        }.resume()
        
    }
}

extension URL {
    
    func createURLWithComponents(baseUrl: String) -> URL? {
        
        let components = NSURLComponents()
        components.scheme = "https";
        components.host = "api.flickr.com";
        components.path = "/services/feeds/photos_public.gne";
        
        let format = URLQueryItem(name: "format", value:"json")
        let conceptQuery = URLQueryItem(name: "nojsoncallback", value: "1")
        components.queryItems = [format, conceptQuery]
        return components.url
    }
}
