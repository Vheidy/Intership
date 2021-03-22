//
//  MainScreenViewModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 16.03.2021.
//

import Foundation


protocol MainScreenViewModelProtocol: AnyObject {
    func countCells() -> Int
    func getFields(for index: Int) -> DisplayModel?
}



class MainScreenViewModel: MainScreenViewModelProtocol {
    var dishes: [Dish]
    
    init(dishes: [Dish]) {
        self.dishes = dishes
    }
    
    func countCells() -> Int {
        return dishes.count
    }
    
    func getFields(for index: Int) -> DisplayModel? {
        let dish = dishes[index]
//        if let imageURL = dish.image {
//            //TODO: get image from url
//        }
        let displayModel = DisplayModel(name: dish.name, type: dish.typeDish, image: nil)
        return displayModel
    }
}
