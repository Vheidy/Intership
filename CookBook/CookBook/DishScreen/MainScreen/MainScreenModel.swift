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
    func addDish(dish: Dish)
<<<<<<< HEAD:CookBook/CookBook/DishScreen/MainScreen/MainScreenViewModel.swift
    func deleteRows(index: Int)
    var updateScreen: (() -> ())? {get set}
=======
    func removeDish(at indexPath: IndexPath)
>>>>>>> 9a008e1a620f7133e7b19be088af0314134febff:CookBook/CookBook/DishScreen/MainScreen/MainScreenModel.swift
}



<<<<<<< HEAD:CookBook/CookBook/DishScreen/MainScreen/MainScreenViewModel.swift
class MainScreenViewModel: MainScreenViewModelProtocol {
    var dishes: [Dish]
    var updateScreen: (() -> ())?
=======
class MainScreenModel: MainScreenViewModelProtocol {
    private var dishes: [Dish]
    var updateView: (()->())?
>>>>>>> 9a008e1a620f7133e7b19be088af0314134febff:CookBook/CookBook/DishScreen/MainScreen/MainScreenModel.swift
    
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
    
    func addDish(dish: Dish) {
<<<<<<< HEAD:CookBook/CookBook/DishScreen/MainScreen/MainScreenViewModel.swift
        dishes.append(dish)
        updateScreen?()
    }
    
    func deleteRows(index: Int) {
        dishes.remove(at: index)
        updateScreen?()
=======
        dishes.insert(dish, at: 0)
        updateView?()
    }
    
    func removeDish(at indexPath: IndexPath) {
        dishes.remove(at: indexPath.row)
        updateView?()
>>>>>>> 9a008e1a620f7133e7b19be088af0314134febff:CookBook/CookBook/DishScreen/MainScreen/MainScreenModel.swift
    }
}
