//
//  StaticClasses.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 14/11/2021.
//

import Foundation

class ModuleAssignment {
    var username = ""
    var surveyName = ""
    var modules : [Module]? = nil
}

class Module1 {
    var name = ""
    var questions : [Question]? = nil
    var dateAdded : [Date]? = nil
}

class Question1 {
    var questionID : Int = 0
    var question = ""
    var answerType = ""
    var answerChoices : [String]? = nil
    var priority = ""
    var nextQuestionId : Int? = nil
}

class Answer1 {
    var username = ""
    var question = ""
    var answer = ""
    var answerChangeCount = ""
}
