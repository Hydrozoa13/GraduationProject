//
//  FavoritesCollectionView.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 31.01.24.
//

import UIKit
import RealmSwift

class FavoritesCollectionView: UICollectionView {
    
    private var favoriteDrinksList: Results<DrinkRealmModel> = StorageService.getFavoriteDrinksList()
    private var notificationToken: NotificationToken?
   
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(FavoritesCVC.self, forCellWithReuseIdentifier: FavoritesCVC.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setNotificationToken()
    }
    
    private func setNotificationToken() {
        
        notificationToken = favoriteDrinksList.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self else { return }
            
            switch changes {
                case .initial:
                    collectionView.reloadData()
                case .update(_, let deletions, let insertions, _):
                    collectionView.performBatchUpdates({
                        collectionView.deleteItems(at: deletions.map { IndexPath(row: $0, section: 0) })
                        collectionView.insertItems(at: insertions.map { IndexPath(row: $0, section: 0) })
                    })
                case .error(let error):
                    fatalError("\(error)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteDrinksList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: FavoritesCVC.reuseId, for: indexPath) as! FavoritesCVC
        let favoriteCocktail = favoriteDrinksList[indexPath.row]
        cell.thumbnailUrl = favoriteCocktail.strDrinkThumb
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        <#code#>
//    }
}
