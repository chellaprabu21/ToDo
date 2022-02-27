//
//  APIManager.swift
//  ToDo
//
//  Created by Chellaprabu V on 25/02/22.
//

import Foundation

let server = "http://167.71.235.242:3000/"
let postUrl =  "http://167.71.235.242:3000/todo/"

protocol APIManagerdelegate{
    func didReceiveResponse(data: ToDoData)
    func didPostData(data: UploadData)
}

struct APIDetails {
    static let APIScheme = "http"
    static let APIHost = "167.71.235.242:3000"
}

public class APIManager{

    static let shared = APIManager()
    
    init(){}
    
    var delegate: APIManagerdelegate?
    
    // MARK: - URL Construction
    private func createURLFromParameters(parameters: [String:Any], pathparam: String) -> URL {

        let url = "\(server)todo"
        var components = URLComponents(string: url)!
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        return components.url!
    }

    func getTaskData(params: [String:Any]){
        let url = createURLFromParameters(parameters: params, pathparam: "todo")
        performRequest(with: url)
    }
    // MARK: - PUT
    
    func completionApi(task: TaskObject,isComplete: Bool){
        
        let taskObj = UploadData(title: task.title,
                              author: "Chellaprabu",
                              is_completed: isComplete,
                              priority: task.priority,
                              tag: task.tag)
        let putURL = "\(postUrl)\(task.id!)"
        let url = URL(string: putURL)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
         
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(taskObj) else {
            print("Error: Trying to convert model to JSON data")
            return
        }

        // Set HTTP Request Body
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                    self.delegate?.didPostData(data: taskObj)
                }
        }
        task.resume()
        
    }
    
    // MARK: - POST
    func postData(_ taskObject: UploadData){
        // Prepare URL
        let url = URL(string: postUrl)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(taskObject) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        // Set HTTP Request Body
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                    self.delegate?.didPostData(data: taskObject)
                }
        }
        task.resume()
    }
    
    // MARK: - GET
    private func performRequest(with url: URL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let safeData = data{
                    self.parseJson(safeData)
                }
                if let error = error {
                    print(error)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                }
            }
            task.resume()
    }
    
    func parseJson(_ data: Foundation.Data){
        let decoder = JSONDecoder()
        do{
            let parsedData = try decoder.decode(ToDoData.self, from: data)
            delegate?.didReceiveResponse(data: parsedData)
        }
        catch{
            print("error")
        }
    }
    
    
}
