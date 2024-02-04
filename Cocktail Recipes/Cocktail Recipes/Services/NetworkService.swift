//
//  NetworkService.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 20.11.23.
//

import UIKit
import Alamofire
import AlamofireImage

final class NetworkService {
    
    static func getThumbnail(thumbnailUrl: String,
                             callback: @escaping (_ result: UIImage?,
                                                  _ error: AFError?) -> ()) {
        if let image = CacheService.shared.imageCache.image(withIdentifier: thumbnailUrl) {
            callback(image, nil)
        } else {
            AF.request(thumbnailUrl).responseImage { response in
                switch response.result {
                case .success(let image):
                    CacheService.shared.imageCache.add(image, withIdentifier: thumbnailUrl)
                    callback(image, nil)
                case .failure(let error): callback(nil, error)
                }
            }
        }
    }
}
