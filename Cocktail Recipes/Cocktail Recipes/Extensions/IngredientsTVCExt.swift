//
//  IngredientsTVCExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

extension IngredientsTVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let clearButton = searchBar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            let img = clearButton.image(for: .normal)
            let tintedClearImage = img?.withTintColor(.lightGray)
            clearButton.setImage(tintedClearImage, for: .normal)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.lowercased()
        filteredIngredients = ingredients.filter({$0.strIngredient1!.lowercased().contains(text)})
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
