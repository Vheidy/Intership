//
//  IngredientScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit
import CoreData


class IngredientScreenTableViewController: UITableViewController {
    
    lazy var ingredientService = IngredientsService(updateView: self.tableView.reloadData)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
//        tableView.tableFooterView = UIView(frame: .zero)
        
        navigationItem.title = "Ingredients"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(presentEditScreen)), animated: true)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func presentEditScreen() {
        let editScreen = EditIngredientTableController(nibName: nil, bundle: nil)
//        editScreen.mainScreen = self
        let navigationController = UINavigationController(rootViewController: editScreen)
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)

<<<<<<< HEAD
        
        navigationItem.title = "Ingredients"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentEditScreen))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
=======

        present(navigationController, animated: true, completion: nil)
>>>>>>> 9a008e1a620f7133e7b19be088af0314134febff
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientService.deleteIngredient(index: indexPath.row)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        ingredientService.ingredientsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ingredientService.fetchIngredient(for: indexPath.row)?.name
        
        return cell
    }
    
    @objc func presentEditScreen() {
        let alertController = UIAlertController(title: "Add ingredient", message: "Enter ingredient name", preferredStyle: .alert)
        
        let actionDone = UIAlertAction(title: "Ok", style: .default) { [unowned self] action in
            
            guard let textField = alertController.textFields?.first, let nameToSave = textField.text, !nameToSave.isEmpty else { return }
            ingredientService.addIngredient(IngredientModel(name: nameToSave, id: UUID().uuidString))
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionDone)
        alertController.addAction(actionCancel)
        alertController.addTextField(configurationHandler: nil)
        
        present(alertController, animated: true, completion: nil)
        
    }
    

//    @objc func presentEditScreen() {
//        let editScreen = IngredientEditTableViewController(nibName: nil, bundle: nil)
//        let nc = UINavigationController(rootViewController: editScreen)
//        nc.navigationBar.barTintColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
//        editScreen.mainScreen = self
//
//        present(nc, animated: true, completion: nil)
//    }
    
=======
        return IngredientService.shared.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let ingredient = IngredientService.shared.fetchIngredient(for: indexPath.row) else { return UITableViewCell() }
        
        cell.textLabel?.text = ingredient.name

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            IngredientService.shared.removeIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
>>>>>>> 9a008e1a620f7133e7b19be088af0314134febff
}

