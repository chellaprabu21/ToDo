//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by Chellaprabu V on 26/02/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var priorityPicker: UISegmentedControl!
    @IBOutlet weak var tagName: UITextField!
    @IBOutlet weak var taskName: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAction(_ sender: Any) {
        
        if (tagName.text == "") || (taskName.text == ""){
            dismiss(animated: true)
            return
        }
        
        let task = UploadData(title: taskName.text,
                              author: "Chella",
                              is_completed: false,
                              priority: TaskDataManager.getPriority(priorityPicker.selectedSegmentIndex),
                              tag: tagName.text)
        dismiss(animated: true) {
            APIManager.shared.postData(task)
        }
    }
}
