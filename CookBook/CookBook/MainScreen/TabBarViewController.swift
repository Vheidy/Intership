//
//  TabBarViewController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let mainScreen = MainNavigationController()
        let ingredientScreen = IngredientScreenTableViewController()
        
        
        
        
        ingredientScreen.tabBarItem.image = UIImage(systemName: "rectangle.fill.on.rectangle.fill")
        mainScreen.tabBarItem.image = UIImage(systemName: "book")
        
        
        self.viewControllers = [mainScreen, ingredientScreen]
    }

}
