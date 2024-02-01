//
//  StorageService.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 26.01.24.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageService {
    
    static func getFavoriteDrinksList() -> Results<DrinkRealmModel> {
        realm.objects(DrinkRealmModel.self)
    }
    
    static func getDrinkRealmModel(by id: String) -> DrinkRealmModel? {
        realm.objects(DrinkRealmModel.self).filter("idDrink == %@", id).first
    }
    
    static func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("deleteAll error: \(error)")
        }
    }
    
    static func saveFavoriteDrink(favoriteDrink: DrinkRealmModel) {
        do {
            try realm.write {
                realm.add(favoriteDrink)
            }
        } catch {
            print("saveFavoriteDrink error \(error)")
        }
    }
    
    static func deleteFavoriteDrink(drinkToDelete: DrinkRealmModel) {
        do {
            try realm.write {
                realm.delete(drinkToDelete)
            }
        } catch {
            print("deleteFavoriteDrink error \(error)")
        }
    }
    
    static func findRealmFile() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
}