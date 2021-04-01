//
//  MainScreenViewModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 16.03.2021.
//

import Foundation
import UIKit

struct DishModel {
    var name: String = ""
    var typeDish: String = ""
    var ingredient: [IngredientModel] = []
    var orderOfAction: [String] = []
    var imageName: String?
    var cuisine: String?
    var calories: Int?
}

struct DisplayItem {
    let name: String
    let type: String
    var image: UIImage?
}

protocol MainScreenViewModelProtocol: AnyObject {
    func countCells() -> Int
    func getFields(for index: Int) -> DisplayItem?
    func addDish(dish: DishModel)
    func deleteRows(index: Int)
    var updateScreen: (() -> ())? {get set}
}



class DishService: MainScreenViewModelProtocol {
    var dishes: [DishModel]
    var updateScreen: (() -> ())?
    
    init(dishes: [DishModel]) {
        self.dishes = dishes
    }
    
    func countCells() -> Int {
        return dishes.count
    }
    
    func getFields(for index: Int) -> DisplayItem? {
        let dish = dishes[index]
        var image: UIImage?
        if let name = dish.imageName {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            var path = paths[0] as String
            path.append(name)
            image = UIImage(contentsOfFile: path)
        }
        let displayModel = DisplayItem(name: dish.name, type: dish.typeDish, image: image)
        return displayModel
    }
    
    func addDish(dish: DishModel) {
        dishes.append(dish)
        updateScreen?()
    }

    func deleteRows(index: Int) {
        dishes.remove(at: index)
        updateScreen?()
    }
}
