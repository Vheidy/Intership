//
//  IngredientService.swift
//  CookBook
//
//  Created by Полина Салюкова on 23.03.2021.
//

import Foundation

struct Ingredient {
    var name: String
}

class IngredientService {
    
    static var shared = IngredientService()
    
    private var ingredients: [Ingredient] = []
    var updateView: (()->())?
    
    func count() -> Int {
        return ingredients.count
    }
    
    func fetchIngredient(for index: Int) -> Ingredient? {
        guard ingredients.indices.contains(index) else { return nil }
        return ingredients[index]
    }
    
    func addIngredient(item: Ingredient) {
        ingredients.insert(item, at: 0)
        updateView?()
    }
    
    func removeIngredient(at index: Int) {
        ingredients.remove(at: index)
        updateView?()
    }
}
