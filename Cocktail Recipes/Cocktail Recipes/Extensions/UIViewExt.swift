//
//  UIViewExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 15.01.24.
//

import UIKit

extension UIView {
    
    func animateView() {
        UIView.animate(withDuration: 2,
                       animations: { [weak self] in
                           self?.alpha = 0.0
                           self?.alpha = 1.0
                       })
    }
    
    func flashAnimation() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.25
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}
