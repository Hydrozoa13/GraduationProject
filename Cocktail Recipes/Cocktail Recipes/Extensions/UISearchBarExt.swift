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
        self.keyboardAppearance = .dark
    }
    
    func makeEmptyResultsLabel(with text: String, for view: UIView) {
        let labelR = UILabel()
        labelR.tag = 100
        labelR.numberOfLines = 0
        labelR.text = "No results for your search\n«‎\(text)»‎"
        labelR.textAlignment = .center
        labelR.textColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        labelR.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.addSubview(labelR)
        labelR.translatesAutoresizingMaskIntoConstraints = false
        let topAnchor = labelR.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        let leftAnchor = labelR.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        let rightAnchor = labelR.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        let heightAnchor = labelR.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([topAnchor, heightAnchor, leftAnchor, rightAnchor])
    }
}
