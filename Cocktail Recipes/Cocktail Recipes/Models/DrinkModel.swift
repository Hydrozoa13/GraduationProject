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
    
    init(idDrink: String, strDrink: String, strDrinkThumb: String) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        
        self.strInstructions = nil
        
        self.strIngredient1 = nil
        self.strIngredient2 = nil
        self.strIngredient3 = nil
        self.strIngredient4 = nil
        self.strIngredient5 = nil
        self.strIngredient6 = nil
        self.strIngredient7 = nil
        self.strIngredient8 = nil
        self.strIngredient9 = nil
        self.strIngredient10 = nil
        self.strIngredient11 = nil
        self.strIngredient12 = nil
        self.strIngredient13 = nil
        self.strIngredient14 = nil
        self.strIngredient15 = nil
        
        self.strMeasure1 = nil
        self.strMeasure2 = nil
        self.strMeasure3 = nil
        self.strMeasure4 = nil
        self.strMeasure5 = nil
        self.strMeasure6 = nil
        self.strMeasure7 = nil
        self.strMeasure8 = nil
        self.strMeasure9 = nil
        self.strMeasure10 = nil
        self.strMeasure11 = nil
        self.strMeasure12 = nil
        self.strMeasure13 = nil
        self.strMeasure14 = nil
        self.strMeasure15 = nil
    }
}

class DrinkRealmModel: Object {
    @Persisted var idDrink = ""
    @Persisted var strDrink = ""
    @Persisted var strDrinkThumb = ""
}
