//
//  DrinkDetailVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

class DrinkDetailVC: UIViewController {
    
    @IBOutlet weak var strDrink: UILabel!
    
    var drink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strDrink.text = drink?.strDrink
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
