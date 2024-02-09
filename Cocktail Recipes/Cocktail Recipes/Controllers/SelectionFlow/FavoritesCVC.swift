//
//  FavoritesCVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 31.01.24.
//

import UIKit

final class FavoritesCVC: UICollectionViewCell {
    
    static let reuseId = "FavoritesCVC"
    
    var thumbnailUrl: String? { didSet { getThumbnailUrl() } }
    var favoriteCocktailName: String? { didSet { strDrinkLabel.text = self.favoriteCocktailName } }
    
    private let mainImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.2277548909, green: 0.2291080356, blue: 0.2468935847, alpha: 1)
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var strDrinkLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviewsWithConstraints()
    }
    
    private func setSubviewsWithConstraints() {
        
        addSubview(mainImageView)
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70).isActive = true
        
        addSubview(strDrinkLabel)
        strDrinkLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        strDrinkLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        strDrinkLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
        strDrinkLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func getThumbnailUrl() {
        if let url = thumbnailUrl {
            NetworkService.getThumbnail(thumbnailUrl: url) { [weak self] image, _ in
                if url == self?.thumbnailUrl {
                    self?.mainImageView.image = image
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
