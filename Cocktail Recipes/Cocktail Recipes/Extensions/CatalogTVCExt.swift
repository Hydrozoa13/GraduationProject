//
//  CatalogTVCExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 20.11.23.
//

import UIKit

extension CatalogTVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let clearButton = searchBar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            let img = clearButton.image(for: .normal)
            let tintedClearImage = img?.withTintColor(.lightGray)
            clearButton.setImage(tintedClearImage, for: .normal)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.lowercased()
        filteredAlcoholicDrinks = alcoholicDrinks.filter({$0.strDrink!.lowercased().contains(text)})
        filteredNonAlcoholicDrinks = nonAlcoholicDrinks.filter({$0.strDrink!.lowercased().contains(text)})
        isSearching = !searchText.isEmpty ? true : false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
