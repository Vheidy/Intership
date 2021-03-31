//
<<<<<<< HEAD
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
    
    // FIXME: Replace singlethon with DI = DONE
    
    // FIXME: NSManagedObject -> Object model - DONE
    private var ingredients = [IngredientModel]()
    private let coreDataService: CoreDataService
    
    private var entity: NSEntityDescription
    private var currentContext: NSManagedObjectContext
    
    var updateView: VoidCallback?
    
//    static var idCount: Int16 = 0
    
    init(updateView: VoidCallback?) {
        coreDataService = CoreDataService()
        self.currentContext = coreDataService.persistentContainer.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Ingredient", in: currentContext) else {fatalError()}
        self.entity = entity
        self.updateView = updateView
        
        self.updateData()
    }
    
    func addIngredient(_ ingredient: IngredientModel) {
//        DispatchQueue.global(qos: .background).async { [unowned self] in
            let ingredientObject = NSManagedObject(entity: entity, insertInto: currentContext)
            
            ingredientObject.setValue(ingredient.name, forKey: "name")
        ingredientObject.setValue(ingredient.id, forKey: "id")
//        IngredientsService.idCount += 1
            do {
                try currentContext.save()
                updateData()
//                print(ingredients)
//                ingredients.append(ingredient)
//                DispatchQueue.main.async { [unowned self] in
                    updateView?()
//                }
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
//        }
        
    }
    
    private func updateData() {
//        DispatchQueue.global(qos: .default).async { [unowned self] in
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
    
    func deleteIngredient(index: Int) {
        guard ingredients.indices.contains(index) else {return}
//        DispatchQueue.global(qos: .background).async { [unowned self] in
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
    
    func fetchIngredient(for index: Int) -> IngredientModel? {
        guard ingredients.indices.contains(index) else {return nil}
        let ingredient = ingredients[index]
        return  ingredient
    }
    
    var ingredientsCount: Int {
        ingredients.count
=======
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
>>>>>>> 9a008e1a620f7133e7b19be088af0314134febff
    }
}
