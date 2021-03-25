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
    //Make Ingredient
    var ingredient: [String] = []
    var orderOfAction: [String] = []
    var image: URL?
    var cuisine: String?
    var calories: Int?
}
