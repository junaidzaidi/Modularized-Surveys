//
//  Question+CoreDataProperties.swift
//  
//
//  Created by Junaid Zaidi on 27/12/2021.
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
    @NSManaged public var isFirst: Bool
    @NSManaged public var nextQuestionId: Int16
    @NSManaged public var question: String?
    @NSManaged public var questionId: Int16
    @NSManaged public var skipAnswer: String?
    @NSManaged public var skipLogic: Bool
    @NSManaged public var skipToQuestionId: Int16
    @NSManaged public var answer: Answer?
    @NSManaged public var module: Module?

}
