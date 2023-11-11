//
//  IngredientModel.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import Foundation

struct Ingredient: Codable {
    
    let id: Int
    let ingredient: String?
    let description: String?
    let type: String?
    let alcohol: String?
    let abv: String?
}
