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
    @IBOutlet private var ingredientsLbls: [UILabel]!
    @IBOutlet private var measuresLbls: [UILabel]!
    @IBOutlet private weak var strInstructions: UILabel!
    
    var drink: Drink? { didSet { getThumbnailUrl() } }
    private var drinkData = [String:[Drink]]()
    private var updatedDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDrinkDetails(drinkId: drink?.idDrink)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        strDrink.text = drink?.strDrink
    }
    
    private func setupDrinkDetail() {
        
        ingredientsLbls.forEach { ingredientLbl in
            guard let text = ingredientLbl.text else { return }
            switch text {
                case "strIngredient1": ingredientLbl.text = updatedDrink?.strIngredient1
                case "strIngredient2": ingredientLbl.text = updatedDrink?.strIngredient2
                case "strIngredient3": ingredientLbl.text = updatedDrink?.strIngredient3
                case "strIngredient4": ingredientLbl.text = updatedDrink?.strIngredient4
                case "strIngredient5": ingredientLbl.text = updatedDrink?.strIngredient5
                case "strIngredient6": ingredientLbl.text = updatedDrink?.strIngredient6
                case "strIngredient7": ingredientLbl.text = updatedDrink?.strIngredient7
                case "strIngredient8": ingredientLbl.text = updatedDrink?.strIngredient8
                case "strIngredient9": ingredientLbl.text = updatedDrink?.strIngredient9
                case "strIngredient10": ingredientLbl.text = updatedDrink?.strIngredient10
                case "strIngredient11": ingredientLbl.text = updatedDrink?.strIngredient11
                case "strIngredient12": ingredientLbl.text = updatedDrink?.strIngredient12
                case "strIngredient13": ingredientLbl.text = updatedDrink?.strIngredient13
                case "strIngredient14": ingredientLbl.text = updatedDrink?.strIngredient14
                case "strIngredient15": ingredientLbl.text = updatedDrink?.strIngredient15
            default: break
            }
            ingredientLbl.isHidden = ingredientLbl.text != nil ? false : true
        }
        
        measuresLbls.forEach { measureLbl in
            guard let text = measureLbl.text else { return }
            switch text {
                case "strMeasure1": measureLbl.text = updatedDrink?.strMeasure1
                case "strMeasure2": measureLbl.text = updatedDrink?.strMeasure2
                case "strMeasure3": measureLbl.text = updatedDrink?.strMeasure3
                case "strMeasure4": measureLbl.text = updatedDrink?.strMeasure4
                case "strMeasure5": measureLbl.text = updatedDrink?.strMeasure5
                case "strMeasure6": measureLbl.text = updatedDrink?.strMeasure6
                case "strMeasure7": measureLbl.text = updatedDrink?.strMeasure7
                case "strMeasure8": measureLbl.text = updatedDrink?.strMeasure8
                case "strMeasure9": measureLbl.text = updatedDrink?.strMeasure9
                case "strMeasure10": measureLbl.text = updatedDrink?.strMeasure10
                case "strMeasure11": measureLbl.text = updatedDrink?.strMeasure11
                case "strMeasure12": measureLbl.text = updatedDrink?.strMeasure12
                case "strMeasure13": measureLbl.text = updatedDrink?.strMeasure13
                case "strMeasure14": measureLbl.text = updatedDrink?.strMeasure14
                case "strMeasure15": measureLbl.text = updatedDrink?.strMeasure15
            default: break
            }
            measureLbl.isHidden = measureLbl.text != nil ? false : true
        }
        
        strInstructions.text = updatedDrink?.strInstructions
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
