//
//  TabBarController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 16.03.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let mainScreen = MainNavigationController(nibName: nil, bundle: nil)
        let ingredientScreen = IngredientScreenTableViewController()
        
        ingredientScreen.tabBarItem.image = UIImage(systemName: "rectangle.fill.on.rectangle.fill")
        mainScreen.tabBarItem.image = UIImage(systemName: "book")
        
        
        self.viewControllers = [mainScreen, ingredientScreen]
    }

}
