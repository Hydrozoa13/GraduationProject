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
        setupUI()
        fetchCocktails(strIngredient: ingredient?.strIngredient1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageSize()
    }

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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Catalog", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DrinkDetailVC") as! DrinkDetailVC
        let drink = cocktails[indexPath.row]
        vc.drink = drink
        navigationController?.present(vc, animated: true)
    }
    
    //MARK: - Private functions
    
    private func setupUI() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        navigationItem.prompt = ingredient?.strIngredient1
        navigationItem.title = "You can make:"
    }

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
