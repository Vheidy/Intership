//
//  RecipeModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 16.03.2021.
//

import Foundation



struct Dish {
    var name: String = ""
    var typeDish: String = ""
    var ingredient: [IngredientModel] = []
    var orderOfAction: [String] = []
    var imageURl: URL?
    var cuisine: String?
    var calories: Int?
}
