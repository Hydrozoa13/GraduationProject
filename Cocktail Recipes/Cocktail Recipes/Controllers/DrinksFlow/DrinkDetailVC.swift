//
//  DrinkDetailVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

class DrinkDetailVC: UIViewController {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var strDrink: UILabel!
    @IBOutlet var ingredientsLbls: [UILabel]!
    @IBOutlet private weak var strInstructions: UILabel!
    
    var drink: Drink? { didSet { getThumbnailUrl() } }
    private var drinkData = [String:[Drink]]()
    private var updatedDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDrinkDetails(drinkId: drink?.idDrink)
    }
    
    //MARK: - Private functions
    
    private func fetchDrinkDetails(drinkId: String?) {
        guard let drinkId,
              let url = URL(string: ApiConstants.drinkDetailPath + drinkId) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                drinkData = try JSONDecoder().decode([String:[Drink]].self, from: data)
                updatedDrink = drinkData["drinks"]?.first
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.setupDrinkDetail()
            }
        }.resume()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        strDrink.text = drink?.strDrink
    }
    
    private func setupDrinkDetail() {
        
        ingredientsLbls.forEach { ingredientLbl in
            guard let text = ingredientLbl.text else { return }
            switch text {
                case "1": ingredientLbl.text = "Ingredients you need:\n\n" + "✧ " +
                                               (updatedDrink?.strMeasure1 ?? "") +
                                               (updatedDrink?.strIngredient1 ?? "")
                case "2": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure2 ?? "") + (updatedDrink?.strIngredient2 ?? "")
                case "3": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure3 ?? "") + (updatedDrink?.strIngredient3 ?? "")
                case "4": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure4 ?? "") + (updatedDrink?.strIngredient4 ?? "")
                case "5": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure5 ?? "") + (updatedDrink?.strIngredient5 ?? "")
                case "6": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure6 ?? "") + (updatedDrink?.strIngredient6 ?? "")
                case "7": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure7 ?? "") + (updatedDrink?.strIngredient7 ?? "")
                case "8": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure8 ?? "") + (updatedDrink?.strIngredient8 ?? "")
                case "9": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure9 ?? "") + (updatedDrink?.strIngredient9 ?? "")
                case "10": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure10 ?? "") + (updatedDrink?.strIngredient10 ?? "")
                case "11": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure11 ?? "") + (updatedDrink?.strIngredient11 ?? "")
                case "12": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure12 ?? "") + (updatedDrink?.strIngredient12 ?? "")
                case "13": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure13 ?? "") + (updatedDrink?.strIngredient13 ?? "")
                case "14": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure14 ?? "") + (updatedDrink?.strIngredient14 ?? "")
                case "15": ingredientLbl.text = "✧ " + (updatedDrink?.strMeasure15 ?? "") + (updatedDrink?.strIngredient15 ?? "")
                default: break
            }
            
            ingredientLbl.text = (ingredientLbl.text == "✧ ") ? "" : ingredientLbl.text
            
            ingredientLbl.isHidden = ingredientLbl.text != "" ? false : true
        }
        
        strInstructions.text = updatedDrink?.strInstructions != nil ?
            "How to make:\n\n\(updatedDrink?.strInstructions ?? "")" : ""
    }
    
    private func getThumbnailUrl() {
        guard let thumbnailUrl = drink?.strDrinkThumb else { return }
        NetworkService.getThumbnail(thumbnailUrl: thumbnailUrl) { [weak self] image, _ in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
