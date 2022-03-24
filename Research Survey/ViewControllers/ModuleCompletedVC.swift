//
//  ModuleCompletedVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 18/01/2022.
//

import UIKit

class ModuleCompletedVC: UIViewController {

    
    //MARK:- IBOutlets
    @IBOutlet weak var moduleNameLbl: UILabel!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nextModuleBtn: UIButton!
    
    @IBOutlet weak var nextModuleView: UIView!
    //MARK:- Helper Variable
    
    var module : Module? = nil
    var nextModule: Module? = nil
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var modules = Helper.modules
        
        modules = modules?.filter({ $0.dateAdded! <= Date()
        })
        modules = modules?.filter({$0.dateAdded! > (module?.dateAdded!)!})
        modules = modules?.filter({$0.isCompleted != true})
        modules?.sort(by: { $0.dateAdded! < $1.dateAdded!
        })
        
        if (modules?.count ?? 0 > 0){
            nextModule = modules![0]
            print(nextModule?.moduleName)
        }
        else {
            nextModuleView.isHidden = true
            
            DispatchQueue.main.async {
                self.nextModuleView.isHidden = true
                self.nextModuleView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
                self.nextModuleView.layoutIfNeeded()
            }
            
        }

        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        nextModuleBtn.layer.cornerRadius = 8
        nextModuleBtn.clipsToBounds = true
        
        homeBtn.layer.cornerRadius = 8
        homeBtn.layer.borderWidth = 1
        homeBtn.clipsToBounds = true
        homeBtn.layer.borderColor = UIColor.systemBlue.cgColor
        
        moduleNameLbl.text = "\(module?.moduleName ?? "") Completed"
    }
    
    //MARK:- Helper Functions
    
    
    //MARK:- IBOutlets
    @IBAction func homeBtnTapped(_ sender: UIButton) {
        if let vc = self.navigationController?.viewControllers.first(where: { $0.isKind(of: HomeVC.self)
        }) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func nextModuleBtnTapped(_ sender: UIButton) {
        var previousAnsweredQuestionsVCs: [UIViewController] = []
        
       
        let questions = nextModule?.questions?.allObjects as? [Question]
        var question = questions?.first(where: {$0.isFirst == true})
        var currentQuestionNumber = 0
        
        while (currentQuestionNumber != nextModule?.lastQuestionAnswered ?? 0) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
            currentQuestionNumber = Int(question!.questionId)
            viewController.module = nextModule
            viewController.question = question
            viewController.questionNumber = Int(question?.questionId ?? 0)
            viewController.moduleName = nextModule?.moduleName ?? ""
            previousAnsweredQuestionsVCs.append(viewController)
            //self.navigationController?.viewControllers.append(viewController)
            
            if (question?.skipLogic == true && question?.answer?.answer?.count ?? 0 > 0) {
                let nextQuestionId = question?.skipAnswer?.contains(question?.answer?.answer?[0] ?? "") ?? true ? question?.skipToQuestionId : question?.nextQuestionId
                question = questions?.first(where: {$0.questionId == nextQuestionId})
                }
            else {
                let nextQuestionId = question?.nextQuestionId
                question = questions?.first(where: {$0.questionId == nextQuestionId})
            }
        }
        
            
        //let question = modules?[indexPath.row].questions?[0]
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
        viewController.module = nextModule
        viewController.question = question
        viewController.questionNumber = Int(question?.questionId ?? 0)
        viewController.moduleName = nextModule?.moduleName ?? ""
        previousAnsweredQuestionsVCs.append(viewController)
        self.navigationController?.viewControllers.append(contentsOf: previousAnsweredQuestionsVCs)
    
    }
}
