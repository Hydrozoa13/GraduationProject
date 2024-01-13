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
        
        let image = UIImage(named: "search")
        let imageView = UIImageView()
        imageView.tag = 100
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageTopAnchor = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        let imageLeftAnchor = imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: UIScreen.main.bounds.width/2-25)
        let imageHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: 50)
        let imageWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([imageTopAnchor, imageLeftAnchor, imageHeightAnchor, imageWidthAnchor])
        
        let labelR = UILabel()
        labelR.tag = 101
        labelR.numberOfLines = 0
        labelR.text = "No results for your search\n«‎\(text)»‎"
        labelR.textAlignment = .center
        labelR.textColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        labelR.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.addSubview(labelR)
        labelR.translatesAutoresizingMaskIntoConstraints = false
        let labelTopAnchor = labelR.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        let labelLeftAnchor = labelR.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        let labelRightAnchor = labelR.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
        let labelHeightAnchor = labelR.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([labelTopAnchor, labelLeftAnchor, labelRightAnchor, labelHeightAnchor])
    }
}
