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
    @IBOutlet private weak var strInstructions: UILabel!
    
    var drinkId: String?
    private var drinkData = [String:[Drink]]()
    private var drink: Drink? {
        didSet {
            getThumbnailUrl()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDrinkDetails(drinkId: drinkId)
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
                drink = drinkData["drinks"]?.first
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.setupDrinkDetail()
            }
        }.resume()
    }
    
    private func setupDrinkDetail() {
        strDrink.text = drink?.strDrink
        strInstructions.text = drink?.strInstructions
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
