//
//  CatalogTVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import UIKit

class CatalogTVC: UITableViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var drinksData = [String:[Drink]]()
    var alcoholicDrinks = [Drink]()
    var nonAlcoholicDrinks = [Drink]()
    var filteredAlcoholicDrinks = [Drink]()
    var filteredNonAlcoholicDrinks = [Drink]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        tableView.register(UINib(nibName: "CatalogCell", bundle: nil),
                                 forCellReuseIdentifier: "Cell")
        navigationItem.titleView = searchBar
        
        fetchDrinks(url: ApiConstants.alcoholicURL, drinkType: .alcoholic)
        fetchDrinks(url: ApiConstants.nonAlcoholicURL, drinkType: .nonAlcoholic)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Cocktails"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailVC
        let drink: Drink?
        
        if indexPath.section == 0 {
            drink = isSearching ? filteredAlcoholicDrinks[indexPath.row] : alcoholicDrinks[indexPath.row]
        } else {
            drink = isSearching ? filteredNonAlcoholicDrinks[indexPath.row] : nonAlcoholicDrinks[indexPath.row]
        }
    
        vc.drink = drink
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        if section == 0 {
            title = isSearching && filteredAlcoholicDrinks.isEmpty ? "" : "Alcoholic"
        } else {
            title = isSearching && filteredNonAlcoholicDrinks.isEmpty ? "" : "Non Alcoholic"
        }
        
        return title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if section == 0 {
            count = isSearching ? filteredAlcoholicDrinks.count : alcoholicDrinks.count
        } else {
            count = isSearching ? filteredNonAlcoholicDrinks.count : nonAlcoholicDrinks.count
        }
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatalogCell
        let drink: Drink?
        
        if indexPath.section == 0 {
            drink = isSearching ? filteredAlcoholicDrinks[indexPath.row] : alcoholicDrinks[indexPath.row]
        } else {
            drink = isSearching ? filteredNonAlcoholicDrinks[indexPath.row] : nonAlcoholicDrinks[indexPath.row]
        }
        
        guard let drink,
              let drinkThumb = drink.strDrinkThumb else { return cell }
        
        cell.thumbnailUrl = drinkThumb + "/preview"
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