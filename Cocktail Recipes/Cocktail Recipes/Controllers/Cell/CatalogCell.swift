//
//  CatalogCell.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 20.11.23.
//

import UIKit
import Alamofire
import AlamofireImage

class CatalogCell: UITableViewCell {
    
    @IBOutlet private weak var cocktailThumb: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textLbl: UILabel!
    
    var thumbnailUrl: String? {
        didSet {
            cocktailThumb.image = nil
            getThumbnailUrl()
        }
    }
    
    private func getThumbnailUrl() {
        if let url = thumbnailUrl {
            NetworkService.getThumbnail(thumbnailUrl: url) { [weak self] image, _ in
                if url == self?.thumbnailUrl {
                    self?.cocktailThumb.layer.cornerRadius = 15
                    self?.cocktailThumb.image = image
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
