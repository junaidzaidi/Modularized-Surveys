//
//  LogInVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 28/10/2021.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class LogInVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK:- Helper Variables
    var userSurvey : UserSurvey?
    var modules: [Module] = []
    var db : Firestore?
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = 10
        loginBtn.clipsToBounds = true
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBActions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        //Check if the credentials are okay
        
        //Retreive the modules list
        
        //let modules = getStaticObject()
        getSurvey()
        
        /*
        let moduleParameters = [
            "date_added": Date(),
            "module_name": "Junaid Final Test 1 7-Dec",
        ] as [String : AnyObject]
        
        var moduleId = self.addModule(params: moduleParameters)
        
        let questionParameters =
            [
            "question": "What letter starts with C?",
            "answer_type": "BCQ",
            "answer_choices": ["Canada","Candy","Australia","British","Boat"],
            "priority" : 1,
            "estimated_time" : 4,
            "next_question_id" : ""
            ] as [String : AnyObject]
        self.addModuleQuestion(moduleId: moduleId ?? "", params: questionParameters)
 */
    }
    
    //MARK:- Helper Functions
    func addModule(params: [String: AnyObject]?) -> String? {
        return Helper.addModule(db: db, parameters: params)
    }
    
    func addModuleQuestion(moduleId: String, params: [String: AnyObject]?) -> String? {
        return Helper.addModuleQuestion(db: db, moduleId: moduleId, parameters: params)
    }
    
    func getSurvey() {
        db?.collection("user_survey").whereField("username", isEqualTo: "jayzaidi@umd.edu").getDocuments { (querySnapshot, error) in
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
        
        var module: Module?
        var questionList: [Question?]? = []
        
        db?.collection("module_question").document(documentId).getDocument { (querySnapshot,error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            module = try? querySnapshot?.data(as: Module.self)
            self.db?.collection("module_question").document(documentId).collection("question").getDocuments { (querySnapshot,error) in
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
