//
//  MainScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit
import CoreData


class MainScreenTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var viewModel: DishService
    
    init(with viewModel: DishService) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.updateScreen = tableView.reloadData
        self.viewModel.fetchController.delegate = self

        setup()
    }
    
    private func setup() {
        navigationItem.title = "CookBook"

        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(presentEditScreen)), animated: true)
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // Add dish to the model
    func addDish(_ dish: DishModel) {
        viewModel.addDish(dish: dish)
    }
    
    // Create and present EditScreen
    @objc func presentEditScreen() {
        let editScreen = EditDishViewController(with: EditScreenModel(), saveAction: self.addDish(_:))
        let navigationController = UINavigationController(rootViewController: editScreen)
        
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - TableViewDelegate implementation
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightCell
    }
    
    // MARK: - TableViewDataSource implementation
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteRows(indexPath: indexPath)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowsInSections(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainScreenTableViewCell else {return UITableViewCell() }
        cell.dishImage?.image = UIImage(named: "dish")
        if let item = viewModel.getFields(for: indexPath) {
            cell.nameLabel?.text = item.name
            cell.dishTypeLabel?.text = item.type
            cell.dishImage?.image = item.image ?? UIImage(named: "dish")
        }
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
