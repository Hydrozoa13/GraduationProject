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
            getThumbnailUrl()
        }
    }
    
    private func getThumbnailUrl() {
        guard let thumbnailUrl else { return }
        NetworkService.getThumbnail(thumbnailUrl: thumbnailUrl) { [weak self] image, _ in
            self?.activityIndicator.stopAnimating()
            self?.cocktailThumb.layer.cornerRadius = 15
            self?.cocktailThumb.image = image
        }
    }
}
