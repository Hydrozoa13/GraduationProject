//
//  CollectionViewCell.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 12.12.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnailUrl()
        }
    }
    
    private func getThumbnailUrl() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        NetworkService.getThumbnail(thumbnailUrl: thumbnailUrl) { [weak self] image, error in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
}
