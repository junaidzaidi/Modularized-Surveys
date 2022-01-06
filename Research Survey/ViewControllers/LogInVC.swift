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
    
    //MARK:- Helper Variables
    var userSurvey : UserSurvey?
    var modules: [Module] = []
    
    let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 10
        loginBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBActions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        //Check if the credentials are okay
        
        //Retreive the modules list
        //getSurvey()
        
        createCoreData()
        
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
    func createCoreData(){
        
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
        question3.question = "What is your age?"
        question3.answerType = "Numeric"
        question3.estimatedTime = 4
        question3.module = newModule1
        
        
        let newModule2 = Module(context: self.coreDataContext)
        newModule2.dateAdded = Calendar.current.date(byAdding: .minute, value: -2, to: Date())
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
        newModule3.dateAdded = Calendar.current.date(byAdding: .minute, value: -1, to: Date())
        newModule3.moduleName = "CoreData Module 3"
        
        do {
            try coreDataContext.save()
            getModulesFromCoreDate()
        }
        catch {
            print("Error Saving Data")
        }
        
    }
    
    func getModulesFromCoreDate(){
        
        do {
            
            let request = Module.fetchRequest() as NSFetchRequest<Module>
            let sortingCriteria = NSSortDescriptor(key: "dateAdded", ascending: true)
            request.sortDescriptors = [sortingCriteria]
            self.modules = try coreDataContext.fetch(request)
            
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC ?? HomeVC()
            homeVC.modules = self.modules
            homeVC.surveyName = "CoreData Survey" //self.userSurvey?.surveyName ?? ""
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        catch {
            print("Error Getting Modules From Core Data")
        }
 
    }
    
    func addModule(params: [String: AnyObject]?) -> String? {
        return Helper.addModule(parameters: params)
    }
    
    func addModuleQuestion(moduleId: String, params: [String: AnyObject]?) -> String? {
        return Helper.addModuleQuestion(moduleId: moduleId, parameters: params)
    }
    
    func getSurvey() {
        Helper.db?.collection("user_survey").whereField("username", isEqualTo: "jayzaidi@umd.edu").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            if let documents = querySnapshot?.documents {
                for document in documents {
                    self.userSurvey = try? document.data(as: UserSurvey.self)
                    for surveyModule in self.userSurvey?.modules ?? [] {
                        self.getModule(documentId: surveyModule) { (module,error) in
                            guard error == nil else {
                                return
                            }
                            if let newModule = module {
                                self.modules.append(newModule)
                            }
                            if(self.modules.count == self.userSurvey?.modules.count) {
                                //Push the view controller
                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC ?? HomeVC()
                                homeVC.modules = self.modules
                                homeVC.surveyName = self.userSurvey?.surveyName ?? ""
                                self.navigationController?.pushViewController(homeVC, animated: true)

                            }
                        }
                       
                    }
                }
            }
        }
    }
    
    func getModule(documentId: String, completion: @escaping (_ data: Module?, _ error: NSError?) -> Void) {
        /*
        var module: Module?
        var questionList: [Question?]? = []
        
        Helper.db?.collection("module_question").document(documentId).getDocument { (querySnapshot,error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            module = try? querySnapshot?.data(as: Module.self)
            Helper.db?.collection("module_question").document(documentId).collection("question").getDocuments { (querySnapshot,error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let questions = querySnapshot?.documents {
                        for question in questions {
                            let tempQues = try? question.data(as: Question.self)
                            questionList?.append(tempQues)
                        }
                        module?.questions = questionList as? [Question]
                        completion(module ?? nil,nil)
                    }
                }
            }
            
        }
         */
    }
    
    /*func getStaticObject() -> ModuleAssignment? {
        
        let textQuestion = Question()
        textQuestion.questionID = 1
        textQuestion.question = "What is your name?"
        textQuestion.answerType = "Text"
        textQuestion.nextQuestionId = 2
        
        
        let numericQuestion = Question()
        numericQuestion.questionID = 2
        numericQuestion.question = "What is your age?"
        numericQuestion.answerType = "Numeric"
        numericQuestion.nextQuestionId = 3
        
        
        let multipleChoiceQuestion = Question()
        multipleChoiceQuestion.questionID = 3
        multipleChoiceQuestion.question = "Which words start with C?"
        multipleChoiceQuestion.answerType = "MCQ"
        multipleChoiceQuestion.answerChoices = ["Cold","Winter","Cool","Summer","Candy"]
        multipleChoiceQuestion.nextQuestionId = 4
        
        let bestChoiceQuestion = Question()
        bestChoiceQuestion.questionID = 4
        bestChoiceQuestion.question = "What is your gender?"
        bestChoiceQuestion.answerType = "BCQ"
        bestChoiceQuestion.answerChoices = ["Male","Female"]
        
        let firstModule = Module()
        firstModule.name = "Test Module 1"
        firstModule.questions = [textQuestion,numericQuestion,multipleChoiceQuestion,bestChoiceQuestion]
        
        
        let secondModule = Module()
        secondModule.name = "Test Module 2"
        secondModule.questions = [numericQuestion,multipleChoiceQuestion,bestChoiceQuestion,textQuestion]
        
        let secondModule1 = Module()
        secondModule1.name = "Test Module 3"
        secondModule1.questions = [multipleChoiceQuestion,textQuestion,numericQuestion,bestChoiceQuestion]
        
        let secondModule2 = Module()
        secondModule2.name = "Test Module 4"
        secondModule2.questions = [bestChoiceQuestion,textQuestion,numericQuestion,multipleChoiceQuestion]
        
        let secondModule3 = Module()
        secondModule3.name = "Test Module 5"
        secondModule3.questions = [textQuestion,numericQuestion,multipleChoiceQuestion,bestChoiceQuestion]
        
        let secondModule4 = Module()
        secondModule4.name = "Test Module 6"
        secondModule4.questions = [textQuestion,numericQuestion,multipleChoiceQuestion,bestChoiceQuestion]
        
        let secondModule5 = Module()
        secondModule5.name = "Test Module 7"
        secondModule5.questions = [textQuestion,numericQuestion,multipleChoiceQuestion,bestChoiceQuestion]
        
        let secondModule6 = Module()
        secondModule6.name = "Test Module 8"
        secondModule6.questions = [textQuestion,numericQuestion,multipleChoiceQuestion,bestChoiceQuestion]
        
        let assignedModules = ModuleAssignment()
        assignedModules.username = "Junaid"
        assignedModules.surveyName = "Test Survey"
        assignedModules.modules = [firstModule]
        
        return assignedModules
    }
    */

}
