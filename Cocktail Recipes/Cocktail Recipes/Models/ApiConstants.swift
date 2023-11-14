//
//  ApiConstants.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import Foundation

struct ApiConstants {
    
    static let serverPath = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    static let alcoholicPath = serverPath + "filter.php?a=Alcoholic"
    static let alcoholicURL = URL(string: alcoholicPath)
    
    static let nonAlcoholicPath = serverPath + "filter.php?a=Non_Alcoholic"
    static let nonAlcoholicURL = URL(string: nonAlcoholicPath)
}
