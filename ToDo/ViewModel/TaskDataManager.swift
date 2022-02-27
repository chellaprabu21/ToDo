//
//  TaskDataManager.swift
//  ToDo
//
//  Created by Chellaprabu V on 26/02/22.
//

import Foundation
import UIKit

struct Params{
    static let pageParam = "_page"
    static let limitParam = "_limit"
    static let authorParam = "author"
}

struct CheckBoxImage{
    static let checked = UIImage(named: "checked")
    static let unchecked = UIImage(named: "unchecked")
}

struct TaskObject{
    var id: Int?
    var title: String
    var tag: String
    var priority: Priority?
    var completed: Bool
    var priorityColour: UIColor
    var checkImage: UIImage?
}

protocol TaskDataManagerDelegate{
    func updateView()
}

class TaskDataManager {
    
    var delegate: TaskDataManagerDelegate?
    
    var page: Int = 1
    var recordNum: Int = 0
    var taskList: [TaskObject] = []
    var taskCount: Int = 0
    var paginating: Bool = false
    let dataFromApi = APIManager()

    private func pageIncrement(){
        page+=1
    }
    
    func triggerData(limit: String){
        paginating = true
        APIManager.shared.delegate = self
        APIManager.shared.getTaskData(params: [Params.pageParam:page,Params.limitParam:limit,Params.authorParam:"Chellaprabu"])
        pageIncrement()
    }
    
    func triggerTaskCompletion(id: Int){
        let taskObject = taskList[id]
        let completionStatus = taskObject.completed ? false : true
        taskList[id].completed = completionStatus
        APIManager.shared.completionApi(task: taskObject, isComplete: completionStatus)
    }

    private func getPriorityColour(_ priority: Priority) -> UIColor{
        
        switch priority {
        case .high:
            return .systemRed
        case .low:
            return .systemGreen
        case .medium:
            return .systemYellow
        default :
            return .systemGray
        }
    }
    
    func getImage(_ isComplete: Bool) -> UIImage?{
        let image = isComplete ? CheckBoxImage.checked : CheckBoxImage.unchecked
        return image
    }
    
    
    class func getPriority(_ value: Int) -> Priority{
        
        switch value{
        case 0 :
            return .low
        case 1 :
            return .medium
        case 2 :
            return .high
        default :
            return .low
        }
    }
}

// MARK: - API Delegate
extension TaskDataManager: APIManagerdelegate{
    
    func didReceiveResponse(data: ToDoData) {
        let taskData = data.data
        taskCount += taskData.count
    
        for taskDatum in taskData {
            let task = TaskObject(id: taskDatum.id,
                                  title: taskDatum.title ?? "",
                                  tag: taskDatum.tag ?? "",
                                  priority: taskDatum.priority,
                                  completed: taskDatum.is_completed ?? false,
                                  priorityColour: getPriorityColour(taskDatum.priority ?? .low),
                                  checkImage: getImage(taskDatum.is_completed ?? false))
            taskList.append(task)
        }
        if taskData.count>0{
        delegate?.updateView()
        }
    }
    
    func didPostData(data: UploadData) {
        delegate?.updateView()
    }
}

