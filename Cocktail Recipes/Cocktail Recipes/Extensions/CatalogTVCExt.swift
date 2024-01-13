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
        self.view.viewWithTag(100)?.removeFromSuperview()
        self.view.viewWithTag(101)?.removeFromSuperview()
        
        let text = searchText.lowercased()
        filteredAlcoholicDrinks = alcoholicDrinks.filter({$0.strDrink!.lowercased().contains(text)})
        filteredNonAlcoholicDrinks = nonAlcoholicDrinks.filter({$0.strDrink!.lowercased().contains(text)})
        
        if !text.isEmpty, filteredAlcoholicDrinks.isEmpty, filteredNonAlcoholicDrinks.isEmpty {
            searchBar.makeEmptyResultsLabel(with: searchText, for: self.view)
        }
        
        isSearching = !searchText.isEmpty ? true : false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
