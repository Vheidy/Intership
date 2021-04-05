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



class DishService {
    
    var dishes: [DishModel]
    var fetchController: NSFetchedResultsController<Dish>
    var updateScreen: (() -> ())?
    
    private let coreDataService: CoreDataService
    private var currentContext: NSManagedObjectContext
    
    var sectionCount: Int {
        return fetchController.sections?.count ?? 0
    }
    
    func rowsInSections(_ section: Int) -> Int {
        guard let sections = fetchController.sections, sections.indices.contains(section), let sectionInfo = fetchController.sections?[section] else {
            return 0
        }
        return sectionInfo.numberOfObjects
    }
    
    init(dishes: [DishModel]) {
        self.dishes = dishes
        coreDataService = CoreDataService()
        self.currentContext = coreDataService.persistentContainer.newBackgroundContext()
        
        let request = NSFetchRequest<Dish>(entityName: "Dish")
        let sort = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [sort]
        
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: currentContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchController.performFetch()
            updateScreen?()
        } catch {
            print("Fetch failed")
        }
        
    }
    
    func loadSavedData() {
        let request = NSFetchRequest<Dish>(entityName: "Dish")
        let sort = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [sort]
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: currentContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchController.performFetch()
            updateScreen?()
        } catch {
            print("Fetch failed")
        }
    }
    
    func countCells() -> Int {
        return dishes.count
    }
    
    func getFields(for indexPath: IndexPath) -> DisplayItem? {
        var imageDish: UIImage?
        let dish = fetchController.object(at: indexPath)
        guard let name = dish.name, let dishType = dish.typeDish else { return nil }
        if let imageName = dish.imageName {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            var path = paths[0] as String
            path.append(imageName)
            imageDish = UIImage(contentsOfFile: path)
        }
        let displayModel = DisplayItem(name: name, type: dishType, image: imageDish)
        return displayModel
    }
    
    //FIXME: Add fetch Ingredients for id and split
    func addDish(dish: DishModel) {
        let dishObject = Dish(context: currentContext)
        dishObject.name = dish.name
        dishObject.typeDish = dish.typeDish
        dishObject.cuisine = dish.cuisine
        dishObject.id = dish.id
        dishObject.imageName = dish.imageName
        dishObject.calories = dish.calories ?? 0
        
        // Transform [String] -> NSSet<Action>
        let setActions = NSSet()
        for action in dish.orderOfAction {
            let actionObject = Action(context: currentContext)
            actionObject.text = action
            setActions.adding(actionObject)
        }
        dishObject.orderOfActions =  setActions
        // Fetch ingredients from CoreData
        do {
            let ingredientService = IngredientsService(updateViewData: nil)
            for ingredient in dish.ingredient {
                if let object = ingredientService.fetchIngredient(for: ingredient.id) {
                    dishObject.addToIngredients(object)
                }
            }
            try currentContext.save()
            loadSavedData()
            updateScreen?()
        } catch {
            print("Save failed")
            print(error)
        }
    }
        
        func deleteRows(indexPath: IndexPath) {
            let dish = fetchController.object(at: indexPath)
            currentContext.delete(dish)
            do {
                try currentContext.save()
                loadSavedData()
                updateScreen?()
            } catch {
                print(error)
            }
    }
}
