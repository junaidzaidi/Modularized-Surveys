//
//  UserSurvey.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 01/12/2021.
//

import Foundation

struct UserSurvey: Codable {
    var userId : String? = nil
    let username : String
    let surveyName : String
    let modules: [String]
    
    enum CodingKeys: String, CodingKey {
        case username
        case surveyName = "survey_name"
        case modules
    }
}
