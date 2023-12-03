//
//  IngredientsTVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 27.11.23.
//

import UIKit

class IngredientsTVC: UITableViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var ingredientsData = [String:[Ingredient]]()
    var ingredients = [Ingredient]()
    var filteredIngredients = [Ingredient]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        tableView.register(UINib(nibName: "CatalogCell", bundle: nil),
                                 forCellReuseIdentifier: "Cell")
        navigationItem.titleView = searchBar
        fetchIngredients(url: ApiConstants.ingredientsListURL)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "IngredientDetailVC") as! IngredientDetailVC
        let ingredient = isSearching ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
        vc.ingredient = ingredient
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isSearching ? filteredIngredients.count : ingredients.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatalogCell
        let ingredient = isSearching ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
        
        guard let ingredientThumb = ingredient.strIngredient1 else { return cell }
        
        cell.thumbnailUrl = ApiConstants.ingredientsThumbsPath + "\(ingredientThumb)-Small.png"
        cell.textLbl.text = ingredientThumb
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
    
    //MARK: - Private functions

    private func fetchIngredients(url: URL?) {
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                ingredientsData = try JSONDecoder().decode([String:[Ingredient]].self, from: data)
                guard let array = ingredientsData["drinks"] else { return }
                ingredients = array
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
