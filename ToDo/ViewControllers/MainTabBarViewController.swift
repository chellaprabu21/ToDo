//
//  MainTabBarViewController.swift
//  ToDo
//
//  Created by Chellaprabu V on 25/02/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        changeAttibutes()
    }

    func changeAttibutes(){
        guard let viewControllers = self.viewControllers else{
            return
        }
        for (index,viewController) in viewControllers.enumerated() {
            switch index{
            case 0:
                viewController.tabBarItem.title = "To Do"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                viewController.tabBarItem.image = UIImage(systemName: "checklist")
            case 1:
                viewController.tabBarItem.title = "Tags"
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                viewController.tabBarItem.image = UIImage(systemName: "tag")
            default:
                viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                viewController.tabBarItem.image = UIImage(systemName: "tag")
            }
        }
    }
}
