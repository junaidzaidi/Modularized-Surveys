//
//  Module+CoreDataProperties.swift
//  
//
//  Created by Junaid Zaidi on 27/12/2021.
//
//

import Foundation
import CoreData


extension Module {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Module> {
        return NSFetchRequest<Module>(entityName: "Module")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var moduleName: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension Module {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
