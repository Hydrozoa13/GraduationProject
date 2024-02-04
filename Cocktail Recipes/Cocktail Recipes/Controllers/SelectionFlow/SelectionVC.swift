//
//  SelectionVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 14.01.24.
//

import UIKit
import RealmSwift

final class SelectionVC: UIViewController {
    
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var appNameLbl: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var randomCocktailBtn: UIButton!
    @IBOutlet weak private var favoritesBackgroundView: UIView!
    
    private var isViewLoadedFirstly = true
    private var drink: Drink?
    private var favoritesCollectionView = FavoritesCollectionView()
    private var favoriteDrinksList: Results<DrinkRealmModel> = StorageService.getFavoriteDrinksList()
    private var notificationToken: NotificationToken?
    
    private var thumbnailUrl: String? {
        didSet {
            imageView.image = nil
            getThumbnailUrl()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDrink(url: ApiConstants.randomCocktailURL)
        setTapGestureRecognizer()
        setLongPressRecognizer()
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        StorageService.setNotificationToken(notificationToken: &notificationToken,
                                            for: favoriteDrinksList,
                                            to: favoritesCollectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isViewLoadedFirstly {
            appNameLbl.animateView()
            backgroundView.animateView()
            randomCocktailBtn.animateView()
            favoritesBackgroundView.animateView()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isViewLoadedFirstly = false
    }
    
    @IBAction private func randomCocktailBtnPressed(_ sender: UIButton) {
        sender.flashAnimation()
        fetchDrink(url: ApiConstants.randomCocktailURL)
    }
    
    //MARK: - Private functions
    
    private func setupUI() {
        backgroundView.layer.cornerRadius = 15
        
        randomCocktailBtn.layer.cornerRadius = 15
        randomCocktailBtn.layer.borderWidth = 3
        randomCocktailBtn.layer.borderColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        
        favoritesBackgroundView.layer.cornerRadius = 15
        favoritesBackgroundView.addSubview(favoritesCollectionView)
        
        favoritesCollectionView.leadingAnchor.constraint(equalTo: favoritesBackgroundView.leadingAnchor, constant: 15).isActive = true
        favoritesCollectionView.trailingAnchor.constraint(equalTo: favoritesBackgroundView.trailingAnchor, constant: -15).isActive = true
        favoritesCollectionView.topAnchor.constraint(equalTo: favoritesBackgroundView.topAnchor, constant: 60).isActive = true
        favoritesCollectionView.bottomAnchor.constraint(equalTo: favoritesBackgroundView.bottomAnchor, constant: -15).isActive = true
        favoritesCollectionView.layer.cornerRadius = 15
    }
    
    private func getThumbnailUrl() {
        if let url = thumbnailUrl {
            NetworkService.getThumbnail(thumbnailUrl: url) { [weak self] image, _ in
                if url == self?.thumbnailUrl {
                    self?.imageView.layer.cornerRadius = 15
                    self?.imageView.animateView()
                    self?.imageView.image = image
                }
            }
        }
    }
    
    private func fetchDrink(url: URL?) {
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                let drinksData = try JSONDecoder().decode([String:[Drink]].self, from: data)
                guard let array = drinksData["drinks"] else { return }
                drink = array.first
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.thumbnailUrl = self.drink?.strDrinkThumb
            }
        }.resume()
    }
}

extension SelectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailVC
        let drink = StorageService.makeDrinkModel(from: favoriteDrinksList[indexPath.row])
        vc.drink = drink
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteDrinksList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCVC.reuseId, for: indexPath) as! FavoritesCVC
        let favoriteCocktail = favoriteDrinksList[indexPath.row]
        cell.thumbnailUrl = favoriteCocktail.strDrinkThumb
        cell.favoriteCocktailName = favoriteCocktail.strDrink
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 15) / 2, height: collectionView.bounds.height )
    }
    
    func setTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
        self.imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setLongPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        favoritesBackgroundView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func tapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if tapGestureRecognizer.state == UIGestureRecognizer.State.ended {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailVC
            vc.drink = self.drink
            present(vc, animated: true)
        }
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CocktailsCVC") as! CocktailsCVC
            present(vc, animated: true)
            vc.isTappedFromFavoriteView.toggle()
        }
    }
}
