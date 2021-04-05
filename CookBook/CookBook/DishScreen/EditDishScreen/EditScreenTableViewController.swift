//
//  EditScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit


class EditDishViewController: UIViewController, UINavigationControllerDelegate {

    var dish: DishModel
    var tableView: UITableView
    var editModel: EditScreenModel
     var imageView: UIImage?
    
    
    private var saveDish: (_ dish: DishModel)->()
    
    // Hightlight cells if they needs to be full
    private var isHightlight = false {
        didSet {
            if isHightlight {
                hightlightCells()
            }
        }
    }
    
    // INIT, saveAction - action for save dish in mainScreen
    init(with model: EditScreenModel, saveAction: @escaping (_ dish: DishModel)->()) {
        self.saveDish = saveAction

        self.dish = DishModel(id: Date())
        self.editModel = model
        self.tableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setup()
    }
    
    // Needs to save dish in mainScreen and close editScreen
    @objc   func addRecipe() {
        self.saveDish(dish)
        closeScreen()
    }
    
    @objc func closeScreen() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // Remove selection when text editing is over
    @objc func tapOnTableView() {
        view.endEditing(true)
        isHightlight = true
    }
    
    // Present screen with ingredient selection functionality
    @objc func presentChooseIngredientScreen() {
        let selectViewController = SelectIngredientsViewController(saveCellsAction: addStandartCells(_:))
        
        navigationController?.pushViewController(selectViewController, animated: true)
    }
    
    // MARK: - Adding cells in sections
    
    // Adding the cells with one label + updateButtomDone
    private func addStandartCells(_ cells: [IngredientModel]) {
        tableView.beginUpdates()
        for cell  in cells {
            let indexPath = editModel.appEnd(section: 2, ingredient: cell)
            tableView.insertRows(at: [indexPath], with: .automatic)
            dish.ingredient.append(cell)
        }
        tableView.endUpdates()
        updateButtonDone()
    }
    

    // Adding the cells with one textField, also highlited this cells if needed + updateButtomDone
    func addInputCells() {
        tableView.beginUpdates()
        let indexPath = editModel.appEnd(section: 3, ingredient: nil)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        if isHightlight {
            guard let cell = tableView.cellForRow(at: indexPath) as? StandartViewCell else { return }
            addBorder(for: cell)
        }
        updateButtonDone()
    }
    
    // MARK: - All about highlighted cells
    
    // Check can the done button be enabled
    func updateButtonDone() {
        if !checkMainFields() {
            isHightlight = true
            navigationItem.rightBarButtonItem?.isEnabled = false
//            createDish()
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    
    // FIXME: MOVE to model
    // Check if the required cells are filled (Name, Type, Ingredients, Actions)
    private func checkMainFields() -> Bool {
        var flag = true
        for sectionNum in 1...3 {
            let rows = editModel.getRowsInSection(section: sectionNum)
            if sectionNum == 2, rows.isEmpty {
                flag = false
                break
            }
            for row in rows.indices {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: sectionNum)) as? StandartViewCell, let textCell = cell.textField?.text, textCell.isEmpty {
                    flag = false
                }
            }
        }
        return flag
    }
    
    // Highlights some of required cells if they have not been filled
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
    
    // MARK: - Setup
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


