//
//  EditScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit


class EditRecipeScreenTableViewController: UITableViewController, UITextFieldDelegate {

    
    var editModel = EditScreenModel()
    var dish = Dish()
    
    var mainViewController: MainScreenTableViewController?
    
    var isHightlight = false {
        didSet {
            if isHightlight {
                hightlightCells()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        tableView.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnTableView)))
        
        configureNavigationItem()
        addRegister()
    }

    private func configureNavigationItem() {
        self.navigationItem.title = "Edit"
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.addRecipe)), animated: true)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(closeScreen)), animated: true)
    }

    private func addRegister() {
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(ImageEditCell.self, forCellReuseIdentifier: "ImageEditCell")
        tableView.register(StandartViewCell.self, forCellReuseIdentifier: "StandartViewCell")
    }
    
    
    @objc   func addRecipe() {
        mainViewController?.viewModel?.addDish(dish: dish)
        closeScreen()
    }
    
    @objc func addPhoto() {
        //ToDO: add the logic for add photo
    }
    
    @objc func tapOnTableView() {
        view.endEditing(true)
    }
    
    @objc func addCell(section: Int) {
        tableView.beginUpdates()
        let indexPath = editModel.appEnd(section: section)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        if isHightlight {
            guard let cell = tableView.cellForRow(at: indexPath) as? StandartViewCell else { return }
            addBorder(for: cell)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if editModel.checkDeleting(indexPath: indexPath) {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    @objc func closeScreen() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addDishInfo(textField)
        if !checkMainFields() {
            isHightlight = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func addDishInfo(_ textfield: UITextField) {
        guard let text = textfield.text else { return }
        switch textfield.placeholder {
        case "Dish Name":
            dish.name = text
        case "Dish Type":
            dish.typeDish = text
        case "Action":
            dish.orderOfAction.append(text)
        case "Ingredient":
            dish.ingredient.append(text)
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor

    }

    private func checkMainFields() -> Bool {
        var flag = true
        for sectionNum in 1...3 {
            let rows = editModel.getRowsInSection(section: sectionNum)
            for row in rows.indices {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: sectionNum)) as? StandartViewCell, let textCell = cell.textField?.text, textCell.isEmpty {
                    flag = false
                }
            }
        }
        return flag
    }
    
    private func hightlightCells() {
        for sectionNum in 1...3 {
            let rows = editModel.getRowsInSection(section: sectionNum)
            for row in rows.indices {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: sectionNum)) as? StandartViewCell, let textCell = cell.textField?.text, textCell.isEmpty {
                    addBorder(for: cell)
                }
            }
        }
    }
  
    private func addBorder(for cell: StandartViewCell) {
        cell.textField?.layer.borderWidth = 2
        cell.textField?.layer.borderColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.2).cgColor
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return editModel.getSectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        editModel.getRowsInSectionCount(section: section)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let cell = editModel.getSection(section: section) else { return nil }
        
        switch cell.needsHeader {
        case .need(let title):
            let view = CustomHeader()
            view.title?.text = title
            view.section = section
            view.action = addCell(section:)
            return view
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard editModel.array.indices.contains(indexPath.section) else { return UITableViewCell() }
        let section = editModel.array[indexPath.section]
        guard section.items.indices.contains(indexPath.row) else { return UITableViewCell() }
        let row = section.items[indexPath.row]
        
        switch row {
        case .image:
            return tableView.dequeueReusableCell(withIdentifier: "ImageEditCell", for: indexPath)
        case .inputItem(let placeholder):
            return createSmallCell(placeholder: placeholder, indexPath: indexPath)
        }
    }
    
    private func createSmallCell(placeholder: String, indexPath: IndexPath) -> StandartViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StandartViewCell", for: indexPath) as? StandartViewCell else { return StandartViewCell() }
        
        cell.configure(with: placeholder)
        cell.textField?.delegate = self
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
}

