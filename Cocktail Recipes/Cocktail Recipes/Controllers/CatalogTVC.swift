//
//  CatalogTVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import UIKit

enum DrinkType {
    case alcoholic
    case nonAlcoholic
}

class CatalogTVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var drinksData = [String:[Drink]]()
    var alcoholicDrinks = [Drink]()
    var nonAlcoholicDrinks = [Drink]()
    var filteredDrinks = [Drink]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        tableView.register(UINib(nibName: "CatalogCell", bundle: nil),
                                 forCellReuseIdentifier: "Cell")
        
        fetchDrinks(url: ApiConstants.alcoholicURL, drinkType: .alcoholic)
        fetchDrinks(url: ApiConstants.nonAlcoholicURL, drinkType: .nonAlcoholic)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let count = isSearching ? 1 : 2
        return count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = section == 0 ? "Alcoholic" : "Non Alcoholic"
        
        if isSearching {
            title = ""
        }
        
        return title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let count = isSearching ? filteredDrinks.count : drinks.count
//        return count
        var count = 0
        
        if section == 0 {
            count = isSearching ? filteredDrinks.count : alcoholicDrinks.count
        } else {
            count = nonAlcoholicDrinks.count
        }
        
        return count
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatalogCell
//        let drink = isSearching ? filteredDrinks[indexPath.row] : drinks[indexPath.row]
        
        var drink = indexPath.section == 0 ? alcoholicDrinks[indexPath.row] :                       nonAlcoholicDrinks[indexPath.row]
        
        if isSearching {
            drink = filteredDrinks[indexPath.row]
        }
        
        cell.thumbnailUrl = drink.strDrinkThumb
        cell.textLbl.text = drink.strDrink
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private functions
    
    private func fetchDrinks(url: URL?, drinkType: DrinkType) {
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                drinksData = try JSONDecoder().decode([String:[Drink]].self, from: data)
                guard let array = drinksData["drinks"] else { return }
                switch drinkType {
                    case .alcoholic: alcoholicDrinks = array
                    case .nonAlcoholic: nonAlcoholicDrinks = array
                }
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
