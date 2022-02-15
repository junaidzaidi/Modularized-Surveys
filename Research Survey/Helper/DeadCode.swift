//
//  DeadCode.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 15/02/2022.
//

import Foundation

class DeadCode {
    /*
    func addModule(params: [String: AnyObject]?) -> String? {
        return Helper.addModule(parameters: params)
    }
    
    func addModuleQuestion(moduleId: String, params: [String: AnyObject]?) -> String? {
        return Helper.addModuleQuestion(moduleId: moduleId, parameters: params)
    }
    */
    
    /*
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
    */
    
    /*
    func getModule(documentId: String, completion: @escaping (_ data: Module?, _ error: NSError?) -> Void) {
        
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
         
    }
    */
    
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
