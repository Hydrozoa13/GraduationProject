//
//  SelectionVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 14.01.24.
//

import UIKit
import RealmSwift

class SelectionVC: UIViewController {
    
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var appNameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak private var randomCocktailBtn: UIButton!
    @IBOutlet weak private var favoritesBackgroundView: UIView!
    
    private var viewState = true
    private var drinksData = [String:[Drink]]()
    var drink: Drink?
    private var favoriteDrinksList: Results<DrinkRealmModel>!
    
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
        setLongPressRecognizer()
        getFavoriteDrinks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewState {
            appNameLbl.animateView()
            backgroundView.animateView()
            randomCocktailBtn.animateView()
            favoritesBackgroundView.animateView()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewState = false
    }
    
    @IBAction func randomCocktailBtnPressed(_ sender: UIButton) {
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
                drinksData = try JSONDecoder().decode([String:[Drink]].self, from: data)
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
    
    private func getFavoriteDrinks() {
        favoriteDrinksList = StorageService.getFavoriteDrinksList()
    }
}
