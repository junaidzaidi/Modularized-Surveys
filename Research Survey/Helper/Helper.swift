//
//  Helper.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 01/12/2021.
//

import Foundation
import FirebaseFirestore
import CoreData


class Helper {
    static let db: Firestore? = Firestore.firestore()
    static var startDate: Date?
    static var modules: [Module]?
    
    static func addAnswer(parameters: [String : AnyObject]?) -> String? {
    
        var ref = db?.collection("user_answer").addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
    
    static func addAnswerInQuestionCollection(parameters: [String : AnyObject]?, collection: String) -> String? {
    
        var ref = db?.collection(collection).addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
    
    static func addTimeLog() -> String? {
        
        let params = ["username": UserDefaults.standard.string(forKey: "LoggedInUsername"),
                      "password": UserDefaults.standard.string(forKey: "UserPassword"),
                      "start_time": startDate,
                      "end_time": Date(),
                      "duration": Calendar.current.dateComponents([.second], from: startDate ?? Date(), to: Date()).second] as [String : AnyObject]
    
        var ref = db?.collection("user_logs").addDocument(data: params ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
    
    static func addFeedback(parameters: [String : AnyObject]?) -> String? {
    
        var ref = db?.collection("user_feedback").addDocument(data: parameters ?? [:]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Question added with ID: \(ref?.documentID)")
            }
        }
        return ref?.documentID
    }
    
    
    static func makeAtrributesString(text: String, boldPartsOfString:[String]=[]) -> NSAttributedString{
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string: text)
        for i in 0 ..< boldPartsOfString.count {
            attributedString.addAttributes(boldFontAttribute as [NSAttributedString.Key : Any], range: attributedString.mutableString.range(of: boldPartsOfString[i] as String))
        }
        return attributedString
    }
    
    static func setUnderlineText(forLabel label : UILabel, onText underlineText: String, labelText : String){
        let text = labelText
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: underlineText)
        
        underlineAttriString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
//        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
//        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
//        myLabel.attributedText = underlineAttributedString

        
//        underlineAttriString.addAttribute(.font, value: UIFont.init(name: AppFontName.bold, size: 15) ?? UIFont.boldSystemFont(ofSize: 15), range: range)
//        underlineAttriString.addAttribute(.foregroundColor, value: tappableTextColor, range: range)
//
        label.attributedText = underlineAttriString
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(tap:)))
//        label.addGestureRecognizer(tap)
//        label.isUserInteractionEnabled = true
    }
    
    static func isSurveyPending() -> Bool{
        let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Module.fetchRequest() as NSFetchRequest<Module>
        let sortingCriteria = NSSortDescriptor(key: "dateAdded", ascending: true)
        request.sortDescriptors = [sortingCriteria]
        do {
            var retrievedModules = try coreDataContext.fetch(request)
//            retrievedModules = retrievedModules.filter({ $0.dateAdded! <= Date()
//            })
            retrievedModules = retrievedModules.filter({ $0.isCompleted == false
            })
            return retrievedModules.count > 0
        }
        catch {
            print("Error Getting Modules From Core Data")
        }
        return false
    }
    
    
}
