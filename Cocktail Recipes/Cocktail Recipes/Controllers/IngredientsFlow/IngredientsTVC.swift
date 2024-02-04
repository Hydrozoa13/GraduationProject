//
//  IngredientsTVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

final class IngredientsTVC: UITableViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var ingredients = [Ingredient]()
    private lazy var filteredIngredients = [Ingredient]()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.setSearchBarUI(with: "Find an ingredient")
        setupUI()
        fetchIngredients(url: ApiConstants.ingredientsListURL)
        setLongPressRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Ingredients"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
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
    
    private func setupUI() {
        navigationItem.titleView = searchBar
        tableView.register(UINib(nibName: "CatalogCell", bundle: nil),
                                 forCellReuseIdentifier: "Cell")
    }

    private func fetchIngredients(url: URL?) {
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                let ingredientsData = try JSONDecoder().decode([String:[Ingredient]].self, from: data)
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
}

extension IngredientsTVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let clearButton = searchBar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            let img = clearButton.image(for: .normal)
            let tintedClearImage = img?.withTintColor(.lightGray)
            clearButton.setImage(tintedClearImage, for: .normal)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.view.viewWithTag(100)?.removeFromSuperview()
        self.view.viewWithTag(101)?.removeFromSuperview()
        
        let text = searchText.lowercased()
        filteredIngredients = ingredients.filter({$0.strIngredient1!.lowercased().contains(text)})
        
        if !text.isEmpty, filteredIngredients.isEmpty {
            navigationItem.title = ""
            searchBar.makeEmptyResultsLabel(with: searchText, for: self.view)
        } else {
            navigationItem.title = "Ingredients"
        }
        
        isSearching = !searchText.isEmpty ? true : false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func setLongPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let vc = storyboard?.instantiateViewController(withIdentifier: "CocktailsCVC") as! CocktailsCVC
                let ingredient = isSearching ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
                vc.ingredient = ingredient
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
