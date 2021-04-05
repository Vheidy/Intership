//
//  EditScreenTableViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit


class EditRecipeScreenTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var dish: DishModel
    
    // FIXME: Try to remove this and create new instance in methods
    private var imagePicker: UIImagePickerController
    
    private var editModel: EditScreenModel
    
    private var imageView: UIImage?
    
    private var saveDish: (_ dish: DishModel)->()
    
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
        imageView = nil
        self.imagePicker = UIImagePickerController()
        self.editModel = model
        super.init(nibName: nil, bundle: nil)

        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Needs to save dish in mainScreen and close editScreen
    @objc   func addRecipe() {

        self.dish.id = Date()
        self.saveDish(dish)
        closeScreen()
    }
    
    // FIXME: Split for several methods and rename
    // Show the alert to choose where get photos
    @objc func addPhoto() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { [unowned self]  action in
            pickPhoto(type: .camera)
        }
        
        actionCamera.setValue(UIImage(systemName: "camera"), forKey: "image")
        actionCamera.setValue(0, forKey: "titleTextAlignment")
        
        let actionPhotoLibrary = UIAlertAction(title: "Library", style: .default) { [unowned self]  action in
            pickPhoto(type: .photoLibrary)
        }
        
        actionPhotoLibrary.setValue(UIImage(systemName: "photo.on.rectangle"), forKey: "image")
        actionPhotoLibrary.setValue(0, forKey: "titleTextAlignment")
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhotoLibrary)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Save the photo when the picking did finish
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        self.imageView = image
        tableView.reloadData()
        var path = NSTemporaryDirectory()
        let name = UUID().uuidString + ".jpeg"
        path.append(name)
        editModel.saveImageToDocuments(image: image, withName: name)
        dish.imageName = name
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Show the picker according the type
    private func pickPhoto(type: UIImagePickerController.SourceType) {
        imagePicker.delegate = self
        imagePicker.sourceType = type
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Remove selection when text editing is over
    @objc func tapOnTableView() {
        view.endEditing(true)
        isHightlight = true
    }
    
    // Present screen with ingredient selection functionality
    @objc func presentChooseIngredientScreen() {
        let selectViewController = SelectIngredientsViewController(saveCellsAction: addStandartCells(_:))
//        selectViewController.saveSelectedCells = addStandartCells(_:)
        
        navigationController?.pushViewController(selectViewController, animated: true)
    }
    
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
    private func addInputCells() {
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
    
    @objc func closeScreen() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
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
    
    // MARK: - TableViewDelegate implementation

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let cell = editModel.getSection(section: section), let sectionTitle = editModel.getTitleSection(section: section) else { return nil }
        
        switch cell.needsHeader {
        case .need(let title):
            // FIXME: Put this in init of CustomHeader
            let headerView = CustomHeader()
            headerView.title?.text = title
            headerView.section = section
            if sectionTitle == "Ingredients" {
                headerView.action = self.presentChooseIngredientScreen
            } else {
                headerView.action = self.addInputCells
            }
            return headerView
        default:
            return nil
        }
    }
    
    // MARK: - TableViewDataSourse implementation
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return editModel.getSectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        editModel.getRowsInSectionCount(section: section)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if editModel.checkDeleting(indexPath: indexPath) {
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = ""
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard editModel.array.indices.contains(indexPath.section) else { return UITableViewCell() }
        let section = editModel.array[indexPath.section]
        guard section.items.indices.contains(indexPath.row) else { return UITableViewCell() }
        let row = section.items[indexPath.row]
        
        switch row {
        case .image:
            let cell = ImageEditCell()
            if let name = dish.imageName {
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                var path = paths[0] as String
                path.append(name)
                cell.imageDish?.image = UIImage(contentsOfFile: path)
            } else {
                cell.imageDish?.image = UIImage(named: "plate")
            }
            cell.addPhoto = self.addPhoto
            return cell
        case .inputItem(let placeholder):
            return createSmallCell(placeholder: placeholder, indexPath: indexPath)
        case .labelItem(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = title
            cell.textLabel?.font = UIFont(name: "Verdana", size: 20)
            cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            return cell
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

extension EditRecipeScreenTableViewController: UITextFieldDelegate {
    
    fileprivate func updateButtonDone() {
        if !checkMainFields() {
            isHightlight = true
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.placeholder {
        case "Dish Name":
            dish.name = textField.text ?? ""
        case "Dish Type":
            dish.typeDish = textField.text ?? ""
        case "Action":
            dish.orderOfAction.append(textField.text ?? "")
        default:
            break
        }
        updateButtonDone()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
    }
}
