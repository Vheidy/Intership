//
//  TabBarViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 31.03.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let ingredientScreen = IngredientScreenTableViewController(nibName: nil, bundle: nil)
        let ingredientNavigationController = UINavigationController(rootViewController: ingredientScreen)
        ingredientNavigationController.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let mainViewController = MainScreenTableViewController(with: DishService(dishes: []))
        let dishNavigationController = UINavigationController(rootViewController: mainViewController)
        ingredientNavigationController.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        ingredientScreen.tabBarItem.image = UIImage(systemName: "rectangle.fill.on.rectangle.fill")
        mainViewController.tabBarItem.image = UIImage(systemName: "book")
        
        self.viewControllers = [dishNavigationController, ingredientNavigationController]
    }

}
