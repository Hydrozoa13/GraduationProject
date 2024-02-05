//
//  UITableViewExt.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 5.02.24.
//

import UIKit

extension UITableViewController {
    
    func animateTableView() {
        
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.height
        var delay = 0.0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            
            UIView.animate(withDuration: 1.3,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                cell.transform = CGAffineTransform.identity
            }
            delay += 1
        }
    }
}
