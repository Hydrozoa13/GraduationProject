//
//  FavoritesCollectionView.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 31.01.24.
//

import UIKit

final class FavoritesCollectionView: UICollectionView {
    
    var listCount = StorageService.getCountOfFavorites() {
        willSet {
            newValue == 0 ? setEmptyListLabelWithConstraints() : emptyListLabel.removeFromSuperview()
        }
    }
    
    private lazy var emptyListLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .lightGray
        
        label.text = """
        The list is empty yet.
        All the recipes you like
        will be shown here
        """
        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        checkListCount()
    }
    
    private func checkListCount() {
        if listCount == 0 {
            setEmptyListLabelWithConstraints()
        }
    }
    
    private func setEmptyListLabelWithConstraints() {
        addSubview(emptyListLabel)
        emptyListLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyListLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
