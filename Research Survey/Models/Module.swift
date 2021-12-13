//
//  Module.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 01/12/2021.
//

import Foundation

struct Module: Codable {
    let moduleName : String?
    let dateAdded : Date?
    var questions : [Question]? = nil
    
    enum CodingKeys: String, CodingKey {
        case moduleName = "module_name"
        case dateAdded = "date_added"
    }
}
