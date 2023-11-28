//
//  IngredientsTVCExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

extension IngredientsTVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            let text = searchText.lowercased()
            filteredIngredients = ingredients.filter({$0.strIngredient1!.lowercased().contains(text)})
            isSearching = true
        } else {
            filteredIngredients = ingredients
            isSearching = false
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
