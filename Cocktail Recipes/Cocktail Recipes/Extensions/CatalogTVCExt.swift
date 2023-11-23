//
//  CatalogTVCExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 20.11.23.
//

import UIKit

extension CatalogTVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            let text = searchText.lowercased()
            filteredDrinks = drinks.filter({$0.strDrink!.lowercased().contains(text)})
            isSearching = true
        } else {
            filteredDrinks = drinks
            isSearching = false
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
