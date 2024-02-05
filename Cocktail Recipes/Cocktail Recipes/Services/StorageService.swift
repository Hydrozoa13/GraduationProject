//
//  StorageService.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 26.01.24.
//

import Foundation
import RealmSwift

let realm = try! Realm()

final class StorageService {
    
    static func getFavoriteDrinksList() -> Results<DrinkRealmModel> {
        realm.objects(DrinkRealmModel.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    static func getCountOfFavorites() -> Int {
        realm.objects(DrinkRealmModel.self).count
    }
    
    static func getDrinkRealmModel(by id: String) -> DrinkRealmModel? {
        realm.objects(DrinkRealmModel.self).filter("idDrink == %@", id).first
    }
    
    static func makeDrinkModel(from favoriteDrink: DrinkRealmModel) -> Drink {
        
        let drink = Drink(idDrink: favoriteDrink.idDrink,
                          strDrink: favoriteDrink.strDrink,
                          strDrinkThumb: favoriteDrink.strDrinkThumb)
        return drink
    }
    
    static func makeDrinkRealmModel(from drink: Drink) -> DrinkRealmModel? {
        
        guard let strDrink = drink.strDrink,
              let strDrinkThumb = drink.strDrinkThumb else { return nil }
        
        let favoriteDrink = DrinkRealmModel()
        favoriteDrink.idDrink = drink.idDrink
        favoriteDrink.strDrink = strDrink
        favoriteDrink.strDrinkThumb = strDrinkThumb
        
        return favoriteDrink
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
