//
//  CocktailsCVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 12.12.23.
//

import UIKit

class CocktailsCVC: UICollectionViewController {
    
    var ingredient: Ingredient?
    private var cocktailsData = [String:[Drink]]()
    private var cocktails = [Drink]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchCocktails(strIngredient: ingredient?.strIngredient1)
        navigationItem.prompt = ingredient?.strIngredient1
        navigationItem.title = "You can make:"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageSize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktails.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let cocktail = cocktails[indexPath.row]
        cell.thumbnailUrl = cocktail.strDrinkThumb
        cell.label.text = cocktail.strDrink
        return cell
    }

    // MARK: - UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    //MARK: - Private functions

    private func fetchCocktails(strIngredient: String?) {
        guard let strIngredient,
              let url = URL(string: ApiConstants.cocktailsPath + strIngredient) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data else { return }
            do {
                cocktailsData = try JSONDecoder().decode([String:[Drink]].self, from: data)
                guard let array = cocktailsData["drinks"] else { return }
                cocktails = array
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.resume()
    }
    
    private func setImageSize() {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }
}
