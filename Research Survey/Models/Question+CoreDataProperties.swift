//
//  Question+CoreDataProperties.swift
//  
//
//  Created by Junaid Zaidi on 23/03/2022.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answerChoices: [String]?
    @NSManaged public var answerType: String?
    @NSManaged public var estimatedTime: Int16
    @NSManaged public var firebaseId: Int16
    @NSManaged public var gridQuestions: [String]?
    @NSManaged public var isFirst: Bool
    @NSManaged public var moduleStartInfo: String?
    @NSManaged public var nextQuestionId: Int16
    @NSManaged public var otherFlag: Bool
    @NSManaged public var otherOption: [String]?
    @NSManaged public var placeholderText: String?
    @NSManaged public var question: String?
    @NSManaged public var questionId: Int16
    @NSManaged public var questionItalicText: String?
    @NSManaged public var skipAnswer: [String]?
    @NSManaged public var skipLogic: Bool
    @NSManaged public var skipToQuestionId: Int16
    @NSManaged public var answer: Answer?
    @NSManaged public var module: Module?

}
