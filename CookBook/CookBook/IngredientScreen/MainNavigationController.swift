//
//  MainNavigationController.swift
//  CookBook
//
//  Created by OUT-Salyukova-PA on 15.03.2021.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let mainScreen = MainScreenTableViewController()
        
        mainScreen.navigationItem.title = "CookBook"
        mainScreen.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add , target: self, action: #selector(self.presentEditScreen)), animated: true)
        viewControllers = [mainScreen]
    }

    @objc func presentEditScreen() {
        let editScreen = EditRecipeScreenTableViewController()
        
//        showDetailViewController(editScreen, sender: nil)
        show(EditRecipeScreenTableViewController(), sender: nil)
    }
}
