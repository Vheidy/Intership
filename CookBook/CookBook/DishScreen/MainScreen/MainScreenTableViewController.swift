//
//  MainScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit

struct DisplayModel {
    let name: String
    let type: String
    var image: UIImage?
}

class MainScreenTableViewController: UITableViewController {
    
    var viewModel: MainScreenViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        navigationItem.title = "CookBook"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(presentEditScreen)), animated: true)
        
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightCell
    }

    @objc func presentEditScreen() {
        
        let editScreen = EditRecipeScreenTableViewController()
        editScreen.mainViewController = self
        let navigationController = UINavigationController(rootViewController: editScreen)
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)


        present(navigationController, animated: true, completion: nil)
    }
    
}
