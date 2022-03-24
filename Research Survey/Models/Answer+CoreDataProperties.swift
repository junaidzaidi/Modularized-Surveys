//
//  Answer+CoreDataProperties.swift
//  
//
//  Created by Junaid Zaidi on 23/03/2022.
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
    @NSManaged public var endTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var totalTime: Double
    @NSManaged public var question: Question?

}
