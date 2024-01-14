//
//  SelectionVCExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 14.01.24.
//

import UIKit

extension SelectionVC {
    
    func setLongPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        self.imageView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailVC
            vc.drink = self.drink
            present(vc, animated: true)
        }
    }
}
