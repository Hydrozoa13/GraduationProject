//
//  NetworkService.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 20.11.23.
//

import UIKit
import Alamofire
import AlamofireImage

class NetworkService {
    static func getThumbnail(thumbnailUrl: String,
                             callback: @escaping (_ result: UIImage?,
                                                  _ error: AFError?) -> ()) {
        AF.request(thumbnailUrl).responseImage { response in
            switch response.result {
            case .success(let image):
                callback(image, nil)
            case .failure(let error): callback(nil, error)
            }
        }
    }
}
