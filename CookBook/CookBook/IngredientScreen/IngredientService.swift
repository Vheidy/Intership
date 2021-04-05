//
//  IngredientModel.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 22.03.2021.
//

import Foundation
import CoreData
import UIKit

typealias VoidCallback = () -> ()

struct IngredientModel {
    var name: String
    var id: String
}

class CoreDataService {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IngredientsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.newBackgroundContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

protocol IngredientServiceProtocol {
    func addIngredient(_ ingredient: IngredientModel)
    func deleteIngredient(index: Int)
    var ingredientsCount: Int { get }
    
    func fetchIngredient(for index: Int) -> IngredientModel?
}

class IngredientsService: IngredientServiceProtocol {
    
    private var ingredients = [IngredientModel]()
    private let coreDataService: CoreDataService
    
//    private var entity: NSEntityDescription
//    private var currentContext: NSManagedObjectContext
    
    private var updateView: VoidCallback?
    
    init(updateViewData: VoidCallback?) {
        coreDataService = CoreDataService()
//        self.currentContext = coreDataService.persistentContainer.newBackgroundContext()
//        guard let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: currentContext) else {fatalError()}
//        self.entity = entity
        self.updateView = updateViewData
        
        self.updateData()
    }
    
    // Add ingredient at ingredients array and CoreData
    func addIngredient(_ ingredient: IngredientModel) {
//        DispatchQueue.global(qos: .default).async { [unowned self] in
        let currentContext = coreDataService.persistentContainer.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: currentContext) else {fatalError()}
//            let ingredientObject = NSManagedObject(entity: entity, insertInto: currentContext)
            let ingredientObject = Ingredient(context: currentContext)
            ingredientObject.id = ingredient.id
            ingredientObject.name = ingredient.name
            do {
                try currentContext.save()
                updateData()
                DispatchQueue.main.async { [unowned self] in
                    updateView?()
                }
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
//        }
        
    }
    
    // Update the ingredients array from coreData
    private func updateData() {
//        DispatchQueue.global(qos: .default).async { [unowned self] in
        let currentContext = coreDataService.persistentContainer.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: currentContext) else {fatalError()}
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Ingredient")
            do {
                let ingredientsObjects = try currentContext.fetch(fetchRequest)
                ingredients = []
                for element in ingredientsObjects {
                    if let name = element.value(forKey: "name") as? String, let id = element.value(forKey: "id") as? String {
                        let ingredient  = IngredientModel(name: name, id: id)
                        ingredients.append(ingredient)
                    }
                }
            } catch {
                print(error)
            }
//        }
    }
    
    //Delete ingredients from ingredients array and CoreData
    func deleteIngredient(index: Int) {
        guard ingredients.indices.contains(index) else {return}
//        DispatchQueue.global(qos: .default).async { [unowned self] in
        let currentContext = coreDataService.persistentContainer.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: currentContext) else {fatalError()}
            let ingredient = ingredients[index]
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Ingredient")
            do {
                let ingredientsObjects = try currentContext.fetch(fetchRequest)
                for object in ingredientsObjects {
                    if let id = object.value(forKey: "id") as? String, id == ingredient.id {
                        currentContext.delete(object)
                        try currentContext.save()
                        updateData()
//                        DispatchQueue.main.async {
                            updateView?()
//                        }
                    }
                }
            } catch {
                print(error)
            }
//        }
    }
    
    //Get ingredient for indexPath
    func fetchIngredient(for index: Int) -> IngredientModel? {
        guard ingredients.indices.contains(index) else {return nil}
        let ingredient = ingredients[index]
        return  ingredient
    }
    
    var ingredientsCount: Int {
        ingredients.count
    }
}
