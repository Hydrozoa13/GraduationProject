//
//  CocktailModel.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import Foundation
import RealmSwift

enum DrinkType {
    case alcoholic
    case nonAlcoholic
}

struct Drink: Codable {
    
    let idDrink: String
    let strDrink: String?
    let strDrinkThumb: String?
    
    let strInstructions: String?
    
    let strIngredient1, strIngredient2, strIngredient3,
        strIngredient4, strIngredient5, strIngredient6,
        strIngredient7, strIngredient8, strIngredient9,
        strIngredient10, strIngredient11, strIngredient12,
        strIngredient13, strIngredient14, strIngredient15: String?
    
    let strMeasure1, strMeasure2, strMeasure3,
        strMeasure4, strMeasure5, strMeasure6,
        strMeasure7, strMeasure8, strMeasure9,
        strMeasure10, strMeasure11, strMeasure12,
        strMeasure13, strMeasure14, strMeasure15: String?
}

class DrinkRealmModel: Object {
    @Persisted var idDrink = ""
    @Persisted var strDrink = ""
    @Persisted var strDrinkThumb = ""
}
