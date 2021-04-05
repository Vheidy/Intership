//
//  MainScreenViewModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 16.03.2021.
//

import Foundation
import UIKit
import CoreData

struct DishModel {
    var name: String = ""
    var typeDish: String = ""
    var ingredient: [IngredientModel] = []
    var orderOfAction: [String] = []
    var imageName: String?
    var cuisine: String?
    var calories: Int32?
    var id: Date
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
//    var fetchController: NSFetchedResultsController<Dish>
    var updateScreen: (() -> ())?
    
    private let coreDataService: CoreDataService
    private var entity: NSEntityDescription
    private var currentContext: NSManagedObjectContext
    
    init(dishes: [DishModel]) {
        self.dishes = dishes
        coreDataService = CoreDataService()
        self.currentContext = coreDataService.persistentContainer.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: currentContext) else {fatalError()}
        self.entity = entity
        
        
//        let request = NSFetchRequest<Dish>(entityName: "Dish")
//        let sort = NSSortDescriptor(key: "id", ascending: false)
//        request.sortDescriptors = [sort]
//        
//        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: currentContext, sectionNameKeyPath: nil, cacheName: nil)
//        //            fetchController.delegate = self
//        
//        //        fetchController.fetchRequest.predicate = commitPredicate
//        
//        do {
//            try fetchController.performFetch()
//            //            tableView.reloadData()
//            updateScreen?()
//        } catch {
//            print("Fetch failed")
//        }
    }
    
    func countCells() -> Int {
        return dishes.count
    }
    
//    func loadSavedData() {
//        let request = NSFetchRequest<Dish>(entityName: "Dish")
//        let sort = NSSortDescriptor(key: "id", ascending: false)
//        request.sortDescriptors = [sort]
//        
//        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: currentContext, sectionNameKeyPath: nil, cacheName: nil)
//        //            fetchController.delegate = self
//        
//        //        fetchController.fetchRequest.predicate = commitPredicate
//        
//        do {
//            try fetchController.performFetch()
//            //            tableView.reloadData()
//            updateScreen?()
//        } catch {
//            print("Fetch failed")
//        }
//    }
    
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
