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
    
    @IBOutlet private weak var strIngredient1: UILabel!
    @IBOutlet private weak var strIngredient2: UILabel!
    @IBOutlet private weak var strIngredient3: UILabel!
    @IBOutlet private weak var strIngredient4: UILabel!
    @IBOutlet private weak var strIngredient5: UILabel!
    @IBOutlet private weak var strIngredient6: UILabel!
    @IBOutlet private weak var strIngredient7: UILabel!
    @IBOutlet private weak var strIngredient8: UILabel!
    @IBOutlet private weak var strIngredient9: UILabel!
    @IBOutlet private weak var strIngredient10: UILabel!
    @IBOutlet private weak var strIngredient11: UILabel!
    @IBOutlet private weak var strIngredient12: UILabel!
    @IBOutlet private weak var strIngredient13: UILabel!
    @IBOutlet private weak var strIngredient14: UILabel!
    @IBOutlet private weak var strIngredient15: UILabel!
    
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
        strIngredient1.text = updatedDrink?.strIngredient1
        strIngredient1.isHidden = strIngredient1.text != nil ? false : true
        strIngredient2.text = updatedDrink?.strIngredient2
        strIngredient2.isHidden = strIngredient2.text != nil ? false : true
        strIngredient3.text = updatedDrink?.strIngredient3
        strIngredient3.isHidden = strIngredient3.text != nil ? false : true
        strIngredient4.text = updatedDrink?.strIngredient4
        strIngredient4.isHidden = strIngredient4.text != nil ? false : true
        strIngredient5.text = updatedDrink?.strIngredient5
        strIngredient5.isHidden = strIngredient5.text != nil ? false : true
        strIngredient6.text = updatedDrink?.strIngredient6
        strIngredient6.isHidden = strIngredient6.text != nil ? false : true
        strIngredient7.text = updatedDrink?.strIngredient7
        strIngredient7.isHidden = strIngredient7.text != nil ? false : true
        strIngredient8.text = updatedDrink?.strIngredient8
        strIngredient8.isHidden = strIngredient8.text != nil ? false : true
        strIngredient9.text = updatedDrink?.strIngredient9
        strIngredient9.isHidden = strIngredient9.text != nil ? false : true
        strIngredient10.text = updatedDrink?.strIngredient10
        strIngredient10.isHidden = strIngredient10.text != nil ? false : true
        strIngredient11.text = updatedDrink?.strIngredient11
        strIngredient11.isHidden = strIngredient11.text != nil ? false : true
        strIngredient12.text = updatedDrink?.strIngredient12
        strIngredient12.isHidden = strIngredient12.text != nil ? false : true
        strIngredient13.text = updatedDrink?.strIngredient13
        strIngredient13.isHidden = strIngredient13.text != nil ? false : true
        strIngredient14.text = updatedDrink?.strIngredient14
        strIngredient14.isHidden = strIngredient14.text != nil ? false : true
        strIngredient15.text = updatedDrink?.strIngredient15
        strIngredient15.isHidden = strIngredient15.text != nil ? false : true
        
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
