//
//  EditIngredientTableController.swift
//  CookBook
//
//  Created by Полина Салюкова on 23.03.2021.
//

import UIKit

class EditIngredientTableController: UITableViewController, UITextFieldDelegate {
    
    var model = IngredientModel()
    var ingredient: Ingredient?
    
//    var mainScreen: IngredientScreenTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        navigationItem.title = "Edit"
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.addIngredient)), animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(closeScreen)), animated: true)
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnTableView)))
        
        tableView.register(StandartViewCell.self, forCellReuseIdentifier: "StandartViewCell")
    }
    
    @objc func tapOnTableView() {
        view.endEditing(true)
    }
    
    @objc func addIngredient() {
        if let newIngredient = self.ingredient {
            IngredientService.shared.addIngredient(item: newIngredient)
        }
        
        closeScreen()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if !text.isEmpty {
            ingredient = Ingredient(name: text)
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func closeScreen() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.getSectionCount()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getRowsInSectionCount(section: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StandartViewCell", for: indexPath) as? StandartViewCell else {return UITableViewCell()}
        
        cell.textField?.placeholder = "Name"
        cell.textField?.delegate = self

        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
