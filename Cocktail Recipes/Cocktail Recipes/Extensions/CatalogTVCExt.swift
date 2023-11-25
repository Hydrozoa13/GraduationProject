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
            filteredDrinks = alcoholicDrinks.filter({$0.strDrink!.lowercased().contains(text)})
            filteredDrinks += nonAlcoholicDrinks.filter({$0.strDrink!.lowercased().contains(text)})
            isSearching = true
        } else {
            filteredDrinks = alcoholicDrinks + nonAlcoholicDrinks
            isSearching = false
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
