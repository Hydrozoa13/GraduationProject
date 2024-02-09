//
//  ApiConstants.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import Foundation

struct ApiConstants {
    
    static let serverPath = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    static let ingredientsThumbsPath = "https://www.thecocktaildb.com/images/ingredients/"
    
    static let alcoholicPath = serverPath + "filter.php?a=Alcoholic"
    static let alcoholicURL = URL(string: alcoholicPath)
    
    static let nonAlcoholicPath = serverPath + "filter.php?a=Non_Alcoholic"
    static let nonAlcoholicURL = URL(string: nonAlcoholicPath)
    
    static let ingredientsListPath = serverPath + "list.php?i=list"
    static let ingredientsListURL = URL(string: ingredientsListPath)
    
    static let drinkDetailPath = serverPath + "lookup.php?i="
    
    static let ingredientDetailPath = serverPath + "search.php?i="
    
    static let cocktailsPath = serverPath + "filter.php?i="
    
    static let randomCocktailPath = serverPath + "random.php"
    static let randomCocktailURL = URL(string: randomCocktailPath)
}
