//
//  CatalogTVCExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 20.11.23.
//

import UIKit

extension CatalogTVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredDrinks.removeAll()
        
        guard searchText != "" || searchText != " " else { return }
        
        for drink in self.drinks {
            let text = searchText.lowercased()
            if let _ = drink.strDrink?.lowercased().range(of: text) {
                filteredDrinks.append(drink)
            }
        }
        
        isSearching = searchBar.text == "" ? false : true
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
