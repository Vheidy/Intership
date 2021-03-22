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
        
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: "cell")
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

}
