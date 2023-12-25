//
//  UISearchBarExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 25.12.23.
//

import UIKit

extension UISearchBar {
    
    func setSearchBarUI(with placeholder: String) {
        self.searchTextField.textColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        self.tintColor = .lightGray
        self.searchTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        self.searchTextField.leftView?.tintColor = .lightGray
    }
}
