//
//  CollectionViewCell.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 12.12.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnailUrl()
        }
    }
    
    private func getThumbnailUrl() {
        if let url = thumbnailUrl {
            NetworkService.getThumbnail(thumbnailUrl: url) { [weak self] image, _ in
                if url == self?.thumbnailUrl {
                    self?.imageView.layer.cornerRadius = 15
                    self?.imageView.image = image
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
