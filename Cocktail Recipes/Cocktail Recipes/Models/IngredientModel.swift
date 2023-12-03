//
//  IngredientModel.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 11.11.23.
//

import Foundation

struct Ingredient: Codable {
    
    let idIngredient: String?
    let strIngredient: String?
    let strIngredient1: String?
    let strDescription: String?
    let strType: String?
    let strAlcohol: String?
    let strABV: String?
}
