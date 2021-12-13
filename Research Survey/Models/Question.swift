//
//  Question.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 01/12/2021.
//

import Foundation
struct Question: Codable {
    
    var questionId: Int?
    let question: String
    let answerType: String
    let answerChoices: [String]?
    let priority: Int?
    let estimatedTime: Int?
    let nextQuestionId: Int?
    var isFirst : Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case questionId = "question_id"
        case question
        case answerType = "answer_type"
        case answerChoices = "answer_choices"
        case priority
        case estimatedTime = "estimated_time"
        case nextQuestionId = "next_question_id"
        case isFirst = "is_first"
    }
}
