//
//  Answer+CoreDataProperties.swift
//  
//
//  Created by Junaid Zaidi on 27/12/2021.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var answer: [String]?
    @NSManaged public var answerChangeCount: Int16
    @NSManaged public var totalTime: Int16
    @NSManaged public var question: Question?

}
