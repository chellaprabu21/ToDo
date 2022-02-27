//
//  ToDoViewController.swift
//  ToDo
//
//  Created by Chellaprabu V on 25/02/22.
//

import UIKit

class TagsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    func configureItems(){
        navigationController?.navigationBar.topItem?.title = "Tags"
        self.tabBarItem.tag = 2
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: nil)
    }
}
