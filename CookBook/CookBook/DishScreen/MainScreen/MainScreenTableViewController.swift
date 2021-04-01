//
//  MainScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit


class MainScreenTableViewController: UITableViewController {
    
    private var viewModel: MainScreenViewModelProtocol?

    init(with viewModel: MainScreenViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.updateScreen = tableView.reloadData
        setup()
    }
    
    private func setup() {
        navigationItem.title = "CookBook"

        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(presentEditScreen)), animated: true)
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // Add dish to the model
    func addDish(_ dish: Dish) {
        viewModel?.addDish(dish: dish)
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
            viewModel?.deleteRows(index: indexPath.row)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let num = viewModel?.countCells() {
            return num
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainScreenTableViewCell
        cell.dishImage?.image = UIImage(named: "dish")
        if let dish = viewModel?.getFields(for: indexPath.row) {
            cell.nameLabel?.text = dish.name
            cell.dishTypeLabel?.text = dish.type
            if let tmpImage = dish.image {
                cell.dishImage?.image = tmpImage
            }
        }
        
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
