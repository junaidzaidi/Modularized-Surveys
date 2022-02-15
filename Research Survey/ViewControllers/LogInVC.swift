//
//  LogInVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 28/10/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreData

class LogInVC: UIViewController {

    
    //MARK:- IBOutlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var hideView: UIView!
    //MARK:- Helper Variables
    var userSurvey : UserSurvey?
    var modules: [Module] = []
    let REGEX_EMAIL = "[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}"
    
    let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let center = UNUserNotificationCenter.current()
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if((UserDefaults.standard.string(forKey: "LoggedInUsername")) != nil) {
            self.view.showBlurLoader()
            getModulesFromCoreDate()
        }
        else{
            self.hideView.isHidden = true
        }
        loginBtn.layer.cornerRadius = 10
        loginBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK:- IBActions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        //Check if the credentials are okay
        
        //Username or Password Can't be empty
        
        if(usernameTxtFld.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false || passwordTxtFld.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false) {
            presentInvalidCredentialsAlert()
        }
        
        do {
            let regex = try NSRegularExpression(pattern: REGEX_EMAIL, options: [])
            if regex.firstMatch(in: usernameTxtFld.text!, options: [], range: NSRange(location: 0, length: usernameTxtFld.text!.utf16.count)) != nil {
                let password = passwordTxtFld.text
                switch password {
                case "1":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    createCoreDataWithOneModule()
                case "2":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    
                    createCoreDataWithAllModules()
                case "3":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(true, forKey: "NotifyUsers")
                    
                    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                        guard error == nil else {
                            print("Error creating notification")
                            return
                        }
                        self.createCoreDataWithNotifyModules()
                    }
                    
                default:
                    presentInvalidCredentialsAlert()
                }
            }
            else{
                presentInvalidCredentialsAlert()
            }
        }
        catch {
            presentInvalidCredentialsAlert()
        }
        
        
        
        //Retreive the modules list
        //getSurvey()
        
        /*
        let moduleParameters = [
            "date_added": Date(),
            "module_name": "Junaid Final Test 1 7-Dec",
        ] as [String : AnyObject]
        
        var moduleId = self.addModule(params: moduleParameters)
        
        let questionParameters =
            [
                "question_id": 1,
                "question": "Is this a skip question?",
                "answer_type": "BCQ",
                "answer_choices": ["Yes","No"],
                "estimated_time" : 4,
                "next_question_id" : 2,
                "skip_logic" : true,
                "skip_answer" : "Yes",
                "skip_to_question_id" : 3,
                "is_first" : true
            ] as [String : AnyObject]
        self.addModuleQuestion(moduleId:"l6tY3VbQMMJyrsgGt8VS", params: questionParameters)
    */
    }
    
    //MARK:- Helper Functions
    func presentInvalidCredentialsAlert(){
        let alert = UIAlertController(title: "Invalid Credientials", message: "Please provide valid Email and Password.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createCoreDataWithOneModule(){
        
        let newModule1 = Module(context: self.coreDataContext)
        newModule1.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule1.moduleName = "CoreData Module 1"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.nextQuestionId = 2
        question1.question = "Would you like to skip your name?"
        question1.answerType = "BCQ"
        question1.answerChoices = ["Yes","No"]
        question1.skipAnswer = "Yes"
        question1.skipLogic = true
        question1.skipToQuestionId = 3
        question1.isFirst = true
        question1.estimatedTime = 4
        question1.module = newModule1
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.nextQuestionId = 3
        question2.question = "What is your name?"
        question2.answerType = "Text"
        question2.estimatedTime = 4
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.nextQuestionId = 4
        question3.question = "What is your age?"
        question3.answerType = "Numeric"
        question3.estimatedTime = 4
        question3.module = newModule1
        
        let question12 = Question(context: self.coreDataContext)
        question12.questionId = 4
        question12.question = "Select all that apply"
        question12.answerType = "MCQ"
        question12.answerChoices = ["Yes","No","Other"]
        question12.estimatedTime = 4
        question12.module = newModule1
        
        do {
            try coreDataContext.save()
            getModulesFromCoreDate()
        }
        catch {
            print("Error Saving Data")
        }
        
    }
    
    func createCoreDataWithAllModules(){
        
        let newModule1 = Module(context: self.coreDataContext)
        newModule1.dateAdded = Calendar.current.date(byAdding: .minute, value: -4, to: Date())
        newModule1.moduleName = "CoreData Module 1"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.nextQuestionId = 2
        question1.question = "Would you like to skip your name?"
        question1.answerType = "BCQ"
        question1.answerChoices = ["Yes","No"]
        question1.skipAnswer = "Yes"
        question1.skipLogic = true
        question1.skipToQuestionId = 3
        question1.isFirst = true
        question1.estimatedTime = 4
        question1.module = newModule1
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.nextQuestionId = 3
        question2.question = "What is your name?"
        question2.answerType = "Text"
        question2.estimatedTime = 4
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.nextQuestionId = 4
        question3.question = "What is your age?"
        question3.answerType = "Numeric"
        question3.estimatedTime = 4
        question3.module = newModule1
        
        let question12 = Question(context: self.coreDataContext)
        question12.questionId = 4
        question12.question = "Select all that apply"
        question12.answerType = "MCQ"
        question12.answerChoices = ["Yes","No","Other"]
        question12.estimatedTime = 4
        question12.module = newModule1
        
        
        let newModule2 = Module(context: self.coreDataContext)
        newModule2.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule2.moduleName = "CoreData Module 2"
        
        let question4 = Question(context: self.coreDataContext)
        question4.questionId = 1
        question4.nextQuestionId = 2
        question4.question = "Would you like to skip your name 12?"
        question4.answerType = "BCQ"
        question4.answerChoices = ["Yes","No"]
        question4.skipAnswer = "Yes"
        question4.skipLogic = true
        question4.skipToQuestionId = 3
        question4.isFirst = true
        question4.estimatedTime = 4
        question4.module = newModule2
        
        let question5 = Question(context: self.coreDataContext)
        question5.questionId = 2
        question5.nextQuestionId = 3
        question5.question = "What is your name 12?"
        question5.answerType = "Text"
        question5.estimatedTime = 4
        question5.module = newModule2
        
        let question6 = Question(context: self.coreDataContext)
        question6.questionId = 3
        question6.question = "What is your age 12?"
        question6.answerType = "Numeric"
        question6.estimatedTime = 4
        question6.module = newModule2
        
        
        let newModule3 = Module(context: self.coreDataContext)
        newModule3.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule3.moduleName = "CoreData Module 3"
        
        let question7 = Question(context: self.coreDataContext)
        question7.questionId = 1
        question7.nextQuestionId = 2
        question7.question = "Would you like to skip your name 12?"
        question7.answerType = "BCQ"
        question7.answerChoices = ["Yes","No","Other"]
        question7.skipAnswer = "Yes"
        question7.skipLogic = true
        question7.skipToQuestionId = 3
        question7.isFirst = true
        question7.estimatedTime = 4
        question7.module = newModule3
        
        let question8 = Question(context: self.coreDataContext)
        question8.questionId = 2
        question8.nextQuestionId = 3
        question8.question = "What is your name 12?"
        question8.answerType = "Text"
        question8.estimatedTime = 4
        question8.module = newModule3
        
        let question9 = Question(context: self.coreDataContext)
        question9.questionId = 3
        question9.question = "What is your age 12?"
        question9.answerType = "Numeric"
        question9.estimatedTime = 4
        question9.module = newModule3
        
        let newModule4 = Module(context: self.coreDataContext)
        newModule4.dateAdded = Calendar.current.date(byAdding: .minute, value: -1, to: Date())
        newModule4.moduleName = "CoreData Module 4"
        
        let question90 = Question(context: self.coreDataContext)
        question90.questionId = 1
        question90.question = "Test Grid Question?"
        question90.answerType = "Grid"
        //question7.answerChoices = ["Yes","No","Other"]
        //question7.skipAnswer = "Yes"
        //question7.skipLogic = true
        //question7.skipToQuestionId = 3
        question90.isFirst = true
        //question7.estimatedTime = 4
        question90.module = newModule4
        
        
        
        do {
            try coreDataContext.save()
            getModulesFromCoreDate()
        }
        catch {
            print("Error Saving Data")
        }
        
    }
    
    func createCoreDataWithNotifyModules(){
        
        let newModule1 = Module(context: self.coreDataContext)
        newModule1.dateAdded = Calendar.current.date(byAdding: .second, value: 0, to: Date())
        newModule1.moduleName = "CoreData Module 1"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.nextQuestionId = 2
        question1.question = "Would you like to skip your name?"
        question1.answerType = "BCQ"
        question1.answerChoices = ["Yes","No"]
        question1.skipAnswer = "Yes"
        question1.skipLogic = true
        question1.skipToQuestionId = 3
        question1.isFirst = true
        question1.estimatedTime = 4
        question1.module = newModule1
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.nextQuestionId = 3
        question2.question = "What is your name?"
        question2.answerType = "Text"
        question2.estimatedTime = 4
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.nextQuestionId = 4
        question3.question = "What is your age?"
        question3.answerType = "Numeric"
        question3.estimatedTime = 4
        question3.module = newModule1
        
        let question12 = Question(context: self.coreDataContext)
        question12.questionId = 4
        question12.question = "Select all that apply"
        question12.answerType = "MCQ"
        question12.answerChoices = ["Yes","No","Other"]
        question12.estimatedTime = 4
        question12.module = newModule1
        
        
        let newModule2 = Module(context: self.coreDataContext)
        let date2 = Calendar.current.date(byAdding: .second, value: 60, to: Date())
        newModule2.dateAdded = date2
        newModule2.moduleName = "CoreData Module 2"
        createLocalNotification(title: "New Module Published", body: "CoreData Module 2 has been released", date: date2!)
        
        let question4 = Question(context: self.coreDataContext)
        question4.questionId = 1
        question4.nextQuestionId = 2
        question4.question = "Would you like to skip your name 12?"
        question4.answerType = "BCQ"
        question4.answerChoices = ["Yes","No"]
        question4.skipAnswer = "Yes"
        question4.skipLogic = true
        question4.skipToQuestionId = 3
        question4.isFirst = true
        question4.estimatedTime = 4
        question4.module = newModule2
        
        let question5 = Question(context: self.coreDataContext)
        question5.questionId = 2
        question5.nextQuestionId = 3
        question5.question = "What is your name 12?"
        question5.answerType = "Text"
        question5.estimatedTime = 4
        question5.module = newModule2
        
        let question6 = Question(context: self.coreDataContext)
        question6.questionId = 3
        question6.question = "What is your age 12?"
        question6.answerType = "Numeric"
        question6.estimatedTime = 4
        question6.module = newModule2
        
        
        let newModule3 = Module(context: self.coreDataContext)
        let date3 = Calendar.current.date(byAdding: .second, value: 120, to: Date())
        newModule3.dateAdded = date3
        newModule3.moduleName = "CoreData Module 3"
        createLocalNotification(title: "New Module Published", body: "CoreData Module 3 has been released", date: date3!)
        
        let question7 = Question(context: self.coreDataContext)
        question7.questionId = 1
        question7.nextQuestionId = 2
        question7.question = "Would you like to skip your name 12?"
        question7.answerType = "BCQ"
        question7.answerChoices = ["Yes","No","Other"]
        question7.skipAnswer = "Yes"
        question7.skipLogic = true
        question7.skipToQuestionId = 3
        question7.isFirst = true
        question7.estimatedTime = 4
        question7.module = newModule3
        
        let question8 = Question(context: self.coreDataContext)
        question8.questionId = 2
        question8.nextQuestionId = 3
        question8.question = "What is your name 12?"
        question8.answerType = "Text"
        question8.estimatedTime = 4
        question8.module = newModule3
        
        let question9 = Question(context: self.coreDataContext)
        question9.questionId = 3
        question9.question = "What is your age 12?"
        question9.answerType = "Numeric"
        question9.estimatedTime = 4
        question9.module = newModule3
        
        do {
            try coreDataContext.save()
            getModulesFromCoreDate()
        }
        catch {
            print("Error Saving Data")
        }
        
    }

    func createLocalNotification(title: String, body: String, date: Date){
        
        
        // Create Notification Content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Create Notification Trigger
        //let date = Calendar.current.date(byAdding: .second, value: days, to: Date())
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create The Request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //Register The Request With Notification Center
        center.add(request) { (error) in
            guard error == nil else {
                print("Error registering notification")
                return
            }
        }
    }
    
    func getModulesFromCoreDate(){
        
        do {
            
            let request = Module.fetchRequest() as NSFetchRequest<Module>
            let sortingCriteria = NSSortDescriptor(key: "dateAdded", ascending: true)
            request.sortDescriptors = [sortingCriteria]
            self.modules = try coreDataContext.fetch(request)
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC ?? HomeVC()
                let notifyUsers = UserDefaults.standard.bool(forKey: "NotifyUsers")
                homeVC.notifyUsers = notifyUsers
                homeVC.modules = self.modules
                homeVC.surveyName = "CoreData Survey" //self.userSurvey?.surveyName ?? ""
                self.view.removeBluerLoader()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
            
        }
        catch {
            print("Error Getting Modules From Core Data")
        }
 
    }
    
    
    
}

