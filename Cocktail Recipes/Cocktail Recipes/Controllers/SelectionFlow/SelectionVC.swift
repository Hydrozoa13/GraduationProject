//
//  SelectionVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 14.01.24.
//

import UIKit

class SelectionVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    private var drinksData = [String:[Drink]]()
    private var drink: Drink?
    
    private var thumbnailUrl: String? {
        didSet {
            imageView.image = nil
            getThumbnailUrl()
        }
    }
    
    @IBAction func randomBtn() { fetchDrink(url: ApiConstants.randomCocktailURL) }
    
    //MARK: - Private functions
    
    private func getThumbnailUrl() {
        if let url = thumbnailUrl {
            NetworkService.getThumbnail(thumbnailUrl: url) { [weak self] image, _ in
                if url == self?.thumbnailUrl {
                    self?.imageView.layer.cornerRadius = 15
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
}
