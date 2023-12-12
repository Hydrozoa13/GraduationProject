//
//  IngredientDetailVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 3.12.23.
//

import UIKit

class IngredientDetailVC: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var strIngredient: UILabel!
    @IBOutlet private var detailsLbls: [UILabel]!
    @IBOutlet private weak var strDescription: UILabel!
    
    var ingredient: Ingredient? { didSet { getThumbnailUrl() } }
    private var ingredientData = [String:[Ingredient]]()
    private var updatedIngredient: Ingredient?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchIngredientDetails(strName: ingredient?.strIngredient1)
    }
    
    //MARK: - Private functions
    
    private func fetchIngredientDetails(strName: String?) {
        guard let strName,
              let url = URL(string: ApiConstants.ingredientDetailPath + strName) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                ingredientData = try JSONDecoder().decode([String:[Ingredient]].self, from: data)
                updatedIngredient = ingredientData["ingredients"]?.first
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.setupIngredientDetail()
            }
        }.resume()
    }
    
    private func setupUI() {
        strIngredient.text = ingredient?.strIngredient1
    }
    
    private func setupIngredientDetail() {
        
        detailsLbls.forEach { detailLbl in
            guard let text = detailLbl.text else { return }
            switch text {
                case "strType": detailLbl.text = "Type: \(updatedIngredient?.strType ?? "unknown")"
                case "strAlcohol": detailLbl.text = "Alcohol: \(updatedIngredient?.strAlcohol ?? "unknown")"
                case "strABV": detailLbl.text = "ABV: \(updatedIngredient?.strABV ?? "unknown")"
                default: break
            }
            
            switch detailLbl.text {
                case "Type: unknown": detailLbl.text = ""
                case "Alcohol: unknown": detailLbl.text = ""
                case "ABV: unknown": detailLbl.text = ""
                case "Alcohol: No": detailLbl.text = ""
                case "ABV: 0": detailLbl.text = ""
                default: break
            }
            
            detailLbl.isHidden = detailLbl.text != "" ? false : true
        }
        strDescription.text = updatedIngredient?.strDescription != nil ? "Description:\n\n\(updatedIngredient?.strDescription ?? "")" : ""
    }
    
    private func getThumbnailUrl() {
        guard let ingredientThumb = ingredient?.strIngredient1 else { return }
        let thumbnailUrl = ApiConstants.ingredientsThumbsPath + "\(ingredientThumb).png"
        NetworkService.getThumbnail(thumbnailUrl: thumbnailUrl) { [weak self] image, _ in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}