//
//  FavoritesCollectionView.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 31.01.24.
//

import UIKit

final class FavoritesCollectionView: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15

        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(FavoritesCVC.self, forCellWithReuseIdentifier: FavoritesCVC.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        contentInset = UIEdgeInsets(top: 0, left: 0,
                                    bottom: 0, right: 0)
        
        backgroundColor = #colorLiteral(red: 0.2277548909, green: 0.2291080356, blue: 0.2468935847, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
