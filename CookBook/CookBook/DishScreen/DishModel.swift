//
//  RecipeModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 16.03.2021.
//

import Foundation

struct Ingredient {
    var name: String
}

struct Dish {
    var name: String
    var typeDish: String
    var ingredient: [Ingredient]
    var orderOfAction: String
    var image: URL?
    var cuisine: String?
    var calories: Int?
}
