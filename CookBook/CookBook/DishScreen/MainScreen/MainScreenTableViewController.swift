//
//  MainScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit
import CoreData


class MainScreenTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
//    private var viewModel: MainScreenViewModelProtocol?
    var fetchController: NSFetchedResultsController<Dish>

    private let coreDataService: CoreDataService
    private var entity: NSEntityDescription
    private var currentContext: NSManagedObjectContext
    

    init(with viewModel: MainScreenViewModelProtocol) {
        coreDataService = CoreDataService()
        self.currentContext = coreDataService.persistentContainer.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Dish", in: currentContext) else {fatalError()}
        self.entity = entity
        let request = NSFetchRequest<Dish>(entityName: "Dish")
        let sort = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [sort]
        
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: currentContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init(nibName: nil, bundle: nil)
//        self.viewModel = viewModel
//        self.viewModel?.updateScreen = tableView.reloadData
        
        
                    fetchController.delegate = self
        //        fetchController.fetchRequest.predicate = commitPredicate
        do {
            try fetchController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
        setup()
    }
    
    func loadSavedData() {
//        if fetchController == nil {
//
//        let currentContext = coreDataService.persistentContainer.newBackgroundContext()
//        guard let entity = NSEntityDescription.entity(forEntityName: "Dish", in: currentContext) else {fatalError()}
        let request = NSFetchRequest<Dish>(entityName: "Dish")
            let sort = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [sort]
//            request.fetchBatchSize = 20

            fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: currentContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchController.delegate = self
//        }


        do {
            try fetchController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
    
    private func setup() {
        navigationItem.title = "CookBook"

        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(presentEditScreen)), animated: true)
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // Add dish to the model
    func addDish(_ dish: DishModel) {
//        let currentContext = coreDataService.persistentContainer.newBackgroundContext()
        let dishObject = Dish(context: currentContext)
        dishObject.name = dish.name
        dishObject.typeDish = dish.typeDish
        dishObject.cuisine = dish.cuisine
        dishObject.id = dish.id
        dishObject.imageName = dish.imageName
        
        // Transform [String] -> NSSet<Action>
        let setActions = NSSet()
        for action in dish.orderOfAction {
            let actionObject = Action(context: currentContext)
            actionObject.text = action
            setActions.adding(actionObject)
        }
        dishObject.orderOfActions =  setActions
        
        let setIngredients = NSSet()
        for ingredient in dish.ingredient {
            let ingredientObject = Ingredient(context: currentContext)
            ingredientObject.name = ingredient.name
            ingredientObject.id = ingredient.id
            setIngredients.adding(ingredientObject)
        }
        dishObject.ingredients = setIngredients
    
        dishObject.calories = dish.calories ?? 0
        
        
        do {
            try currentContext.save()
            loadSavedData()
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
//        viewModel?.addDish(dish: dish)
    }
    
    // Create and present EditScreen
    @objc func presentEditScreen() {
        let editScreen = EditRecipeScreenTableViewController(with: EditScreenModel(), saveAction: self.addDish(_:))
        let navigationController = UINavigationController(rootViewController: editScreen)
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - TableViewDelegate implementation
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightCell
    }
    
    // MARK: - TableViewDataSource implementation
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            viewModel?.deleteRows(index: indexPath.row)
            let dish = fetchController.object(at: indexPath)
            currentContext.delete(dish)
            do {
                try currentContext.save()
                loadSavedData()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchController.sections?.count ?? 0
//        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel?.countCells() ?? 0
        guard let sections = fetchController.sections, sections.indices.contains(section), let sectionInfo = fetchController.sections?[section] else {
            return 0
        }
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainScreenTableViewCell else {return UITableViewCell() }
        cell.dishImage?.image = UIImage(named: "dish")
        let dish = fetchController.object(at: indexPath)
            cell.nameLabel?.text = dish.name
            cell.dishTypeLabel?.text = dish.typeDish
            if let imageName = dish.imageName {
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                var path = paths[0] as String
                path.append(imageName)
                cell.dishImage?.image = UIImage(contentsOfFile: path)
        }
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
