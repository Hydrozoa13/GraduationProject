//
//  FavoritesCVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 31.01.24.
//

import UIKit

class FavoritesCVC: UICollectionViewCell {
    
    static let reuseId = "FavoritesCVC"
    
    private let mainImageView = UIImageView()
    
    var thumbnailUrl: String? {
        didSet {
//            mainImageView.image = nil
            getThumbnailUrl()
        }
    }
    
    private func getThumbnailUrl() {
        if let url = thumbnailUrl {
            NetworkService.getThumbnail(thumbnailUrl: url) { [weak self] image, _ in
                if url == self?.thumbnailUrl {
                    self?.mainImageView.layer.cornerRadius = 15
                    self?.mainImageView.image = image
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImageView)
        
        mainImageView.backgroundColor = .red
        mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
