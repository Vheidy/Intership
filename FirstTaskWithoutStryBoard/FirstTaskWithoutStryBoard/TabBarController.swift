//
//  TabBarController.swift
//  FirstTaskWithoutStryBoard
//
//  Created by OUT-Salyukova-PA on 04.03.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
           setupVCs()
    }
    
    func setupVCs() {
        let firstTaskVC = FirstTaskViewController()
        let secondTaskVC = SecondTaskViewController()
        let thirdTaskVC = ThirdTaskViewController()
        let tableCornerRadiusVC = CornerTableViewController()
        
        setTabBarItem(for: firstTaskVC, named: "Task 1", systemImageName: "app")
        setTabBarItem(for: secondTaskVC, named: "Task 2", systemImageName: "diamond")
        setTabBarItem(for: thirdTaskVC, named: "Task 3", systemImageName: "triangle")
        setTabBarItem(for: tableCornerRadiusVC, named: "", systemImageName: "poweroff")
        
        viewControllers = [
            firstTaskVC, secondTaskVC, thirdTaskVC, tableCornerRadiusVC
        ]
      }

    
    private func setTabBarItem(for viewController: UIViewController, named title: String, systemImageName: String){
        viewController.tabBarItem.image = UIImage(systemName: systemImageName)
    }

}
