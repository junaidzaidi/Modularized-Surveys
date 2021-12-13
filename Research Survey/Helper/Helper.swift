//
//  Helper.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 01/12/2021.
//

import Foundation
import FirebaseFirestore
class Helper {
    static func addModuleQuestion(db: Firestore?, moduleId: String, parameters: [String : AnyObject]?) -> String? {
        /*[
            "question_id" : ""
            "question": "What letter starts with C?",
            "answer_type": "BCQ",
            "answer_choices": ["Canada","Candy","Australia","British"],
            "priority" : 2,
            "estimated_time" : 4,
            "next_question_id" : ""
            ]*/
        var ref = db?.collection("module_question").document(moduleId).collection("question").addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Question added with ID: \(ref?.documentID)")
            }
        }
        
        return ref?.documentID
    }
    
    static func addModule(db: Firestore?, parameters: [String : AnyObject]?) -> String? {
        /*
        [
            "date_added": Date(),
            "module_name": "Junaid Test Module 2",
            ]
         */
        var ref = db?.collection("module_question").addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
    
    static func addUserSurvey(db: Firestore?, parameters: [String : AnyObject]?) -> String? {
        /*
        [
            "username": "junaid_masroor@hotmail.com,
            "survey_name": "Junaid Test Module 2",
            "modules": [""]
        ]
         */
        var ref = db?.collection("user_survey").addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
    /*
    static func assignModuleToUser(db: Firestore?, parameters: [String : AnyObject]?) -> String? {
        /*
        [
            "username": Date(),
            "survey_name": "Junaid Test Module 2",
            "modules": [""]
            ]
         */
        var ref = db?.collection("user_survey").addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
 */
}
