//
//  MainNavigationController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit

class MainNavigationController: UINavigationController {

    var mainViewController: MainScreenTableViewController?
    var editViewController: EditRecipeScreenTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        mainViewController = MainScreenTableViewController()
        let viewModel = MainScreenViewModel(dishes: [])
        
        navigationBar.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        


        
        mainViewController?.navigationItem.title = "CookBook"
        let borsh = createOneDish()
        viewModel.dishes.append(borsh)
        mainViewController?.viewModel = viewModel
        

        mainViewController?.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(presentEditScreen)), animated: true)
        if mainViewController != nil {
            viewControllers = [mainViewController!]
        }
    }

    private func createOneDish() -> Dish {
        let dish = Dish(name: "Borsh",
                        typeDish: "Soup",
                        ingredient: [Ingredient(name: "Carrot"), Ingredient(name: "Potato")],
                        orderOfAction: "Do something with all this stuff",
                        image: nil,
                        cuisine: "Ukranian",
                        calories: nil)
        return dish
    }


    @objc func presentEditScreen() {
        
        let tmp = EditRecipeScreenTableViewController()
//        guard let tmp = editViewController else { return }
        let nc = UINavigationController(rootViewController: tmp)
        nc.navigationBar.barTintColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)


        present(nc, animated: true, completion: nil)
    }
}
