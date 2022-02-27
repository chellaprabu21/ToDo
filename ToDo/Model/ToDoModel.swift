// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct UploadData: Codable {
    let title: String?
    let author: String?
    let is_completed: Bool?
    let priority: Priority?
    let tag: String?
}

// MARK: - ToDoData
struct ToDoData: Codable {
    let data: [Data]
    let total_records: Int
}

// MARK: - Data
struct Data: Codable {
    let title: String?
    let author: String?
    let tag: String?
    let is_completed: Bool?
    let priority: Priority?
    let id: Int?
    let action: String?
    let username: String?
    let phonenumber: String?
    let type: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title,author,tag,is_completed,priority,id,action
        case username = "USERNAME"
        case phonenumber = "PHONENUMBER"
        case type = "TYPE"
    }
}


enum Priority: String, Codable {
    case high = "HIGH"
    case low = "LOW"
    case medium = "MEDIUM"
}
