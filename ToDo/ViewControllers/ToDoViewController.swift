//
//  ViewController.swift
//  ToDo
//
//  Created by Chellaprabu V on 25/02/22.
//

import UIKit

class ToDoViewController: UIViewController {

    let searchController = UISearchController()
    lazy var viewModel: TaskDataManager = {
        let viewModel = TaskDataManager()
        return viewModel
    }()

    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table View
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        toDoTableView.separatorStyle = .none
        toDoTableView.showsVerticalScrollIndicator = false
        
        configureItems()
        navigationItem.searchController = searchController
        
        viewModel.delegate = self
        viewModel.triggerData(limit: "15")
    }
    
    func configureItems(){
        
        navigationController?.navigationBar.topItem?.title = "To Do"
        self.tabBarItem.tag = 1
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    // MARK: - Bottom Screen
    @objc func didTapAdd(){
        presentModal()
    }
    
    private func presentModal() {
        let addViewController = AddTaskViewController()
        let nav = UINavigationController(rootViewController: addViewController)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - Data Source Delegate
extension ToDoViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        cell.delegate = self
        cell.title.text = viewModel.taskList[indexPath.item].title
        cell.tabLabel.text = viewModel.taskList[indexPath.item].tag
        cell.priorityImage.tintColor = viewModel.taskList[indexPath.item].priorityColour
        cell.check.setImage(viewModel.getImage(viewModel.taskList[indexPath.item].completed), for: .normal)
        cell.check.tag = indexPath.row
        return cell
    }
    
}

// MARK: - Table View Delegate
extension ToDoViewController: UITableViewDelegate{

}

// MARK: - Cell Delegate
extension ToDoViewController: TaskTableViewCellDelegate{

    func didClickCheckBox(cell: UITableViewCell) {
        if let indexPath = toDoTableView.indexPath(for: cell) {
            print("User did tap cell with index: \(indexPath.row)")
            viewModel.triggerTaskCompletion(id: indexPath.row)
        }
    }
}
// MARK: - Sroll view Delegate
extension ToDoViewController: UIScrollViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        
        if pos > toDoTableView.contentSize.height-100-scrollView.frame.size.height{
            
            guard !viewModel.paginating else {return}
            
            viewModel.triggerData(limit: "15")
        }
    }
    
}

// MARK: - Task Manager View Model Delegate
extension ToDoViewController: TaskDataManagerDelegate{
    
    func updateView() {
        DispatchQueue.main.async {
            self.toDoTableView.reloadData()
        }
        viewModel.paginating = false
    }
}

