//
//  IngredientsTVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

class IngredientsTVC: UITableViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var ingredientsData = [String:[Ingredient]]()
    var ingredients = [Ingredient]()
    var filteredIngredients = [Ingredient]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPressRecognizer)
        
        tableView.register(UINib(nibName: "CatalogCell", bundle: nil),
                                 forCellReuseIdentifier: "Cell")
        navigationItem.titleView = searchBar
        fetchIngredients(url: ApiConstants.ingredientsListURL)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "IngredientDetailVC") as! IngredientDetailVC
        let ingredient = isSearching ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
        vc.ingredient = ingredient
        navigationController?.present(vc, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isSearching ? filteredIngredients.count : ingredients.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatalogCell
        let ingredient = isSearching ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
        
        guard let ingredientThumb = ingredient.strIngredient1 else { return cell }
        
        cell.thumbnailUrl = ApiConstants.ingredientsThumbsPath + "\(ingredientThumb)-Small.png"
        cell.textLbl.text = ingredientThumb
        return cell
    }
    
    //MARK: - Private functions

    private func fetchIngredients(url: URL?) {
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                ingredientsData = try JSONDecoder().decode([String:[Ingredient]].self, from: data)
                guard let array = ingredientsData["drinks"] else { return }
                ingredients = array
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let vc = storyboard?.instantiateViewController(withIdentifier: "CocktailsCVC") as! CocktailsCVC
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


