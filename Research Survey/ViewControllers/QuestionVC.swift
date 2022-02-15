//
//  QuestionVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 30/10/2021.
//

import UIKit

class QuestionVC: UIViewController {

    var answerType : String = "MCQ"

    //MARK:- IBOutlets
   
    @IBOutlet weak var headerTitleLbl: UILabel!
   
    @IBOutlet weak var questionNumberLbl: UILabel!
    @IBOutlet weak var moduleNameLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeView: UIView!
    //MARK:- Helper Variables
    
    var module : Module? = nil
    var question : Question? = nil
    var moduleName = ""
    var questionNumber : Int = 0
    var answer : [String] = []
    
    let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
   
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.hideKeyboardWhenTappedAround()
       // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
      
       
    }
       
    override func viewWillAppear(_ animated: Bool) {
       DispatchQueue.main.async {
           self.homeView.dropShadow()
       }
        answer = question?.answer?.answer ?? []
        moduleNameLbl.text = moduleName
        questionLbl.text = question?.question ?? ""
        questionNumberLbl.text = "\(questionNumber)/\(module?.questions?.count ?? 0)"
       
    }
    //MARK:- IBActions

    @IBAction func backBtnTapped(_ sender: UIButton) {
       
        if let vc = self.navigationController?.viewControllers.first(where: { $0.isKind(of: HomeVC.self)
        }) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }


    //MARK:- Helper Functions
    func setup() {
       
        tableView.delegate = self
        tableView.dataSource = self
       
        
        tableView.register(UINib(nibName: "OtherMCQTVC", bundle: nil), forCellReuseIdentifier: "OtherMCQTVC")
        tableView.register(UINib(nibName: "MultipleChoiceTVC", bundle: nil), forCellReuseIdentifier: "MultipleChoiceTVC")
        tableView.register(UINib(nibName: "BestChoiceTVC", bundle: nil), forCellReuseIdentifier: "BestChoiceTVC")
        tableView.register(UINib(nibName: "TextTVC", bundle: nil), forCellReuseIdentifier: "TextTVC")
        tableView.register(UINib(nibName: "NumericTVC", bundle: nil), forCellReuseIdentifier: "NumericTVC")
        tableView.register(UINib(nibName: "GridSatisfyTVC", bundle: nil), forCellReuseIdentifier: "GridSatisfyTVC")
        
        tableView.register(UINib(nibName: "FooterTVC", bundle: nil), forHeaderFooterViewReuseIdentifier: "FooterTVC")
        
        
        

    }

    func configure() {
       
    }
    
    func pushNewQuestionVC(question: Question? , questionNumber: Int16?) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
        viewController.module = module
        viewController.question = question
        viewController.questionNumber = Int(questionNumber ?? 0)
        viewController.moduleName = moduleName
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func writeAnswerToFirestore() {
        let params = [
            "username": "jayzaidi@umd.edu",
            "module_name": moduleName,
            "question": question?.question,
            "question_type": question?.answerType,
            "answer": answer,
            "change_count": 0,
            "time_taken": 10
        ] as [String : AnyObject]
        
        Helper.addAnswer(parameters: params)
    }
    
    func saveAnswerInCoreData() {
        let answerToStore = Answer(context: self.coreDataContext)
        answerToStore.answer = answer
        answerToStore.question = question
        
        do {
            try coreDataContext.save()
            
        }
        catch {
            print("Error Saving Data")
        }
    }
    
}

extension QuestionVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question?.answerChoices?.count == nil ? 1 : question?.answerChoices?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch question?.answerType ?? "" {
        
            case "MCQ":
                if (question?.answerChoices?[indexPath.row] ?? "" == "Other") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMCQTVC", for: indexPath) as? OtherMCQTVC ?? OtherMCQTVC()
                    answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActiveCheck(state: true) : cell.setActiveCheck(state: false)
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceTVC", for: indexPath) as? MultipleChoiceTVC ?? MultipleChoiceTVC()
                cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActive(state: true) : cell.setActive(state: false)
                return cell
                
        
            case "BCQ":
                if (question?.answerChoices?[indexPath.row] ?? "" == "Other") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMCQTVC", for: indexPath) as? OtherMCQTVC ?? OtherMCQTVC()
                    answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActiveRadio(state: true) : cell.setActiveRadio(state: false)
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "BestChoiceTVC", for: indexPath) as? BestChoiceTVC ?? BestChoiceTVC()
                cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActive(state: true) : cell.setActive(state: false)
                return cell
            
            
            case "Text":
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextTVC", for: indexPath) as? TextTVC ?? TextTVC()
                cell.delegate = self
                
                let previousAnswer = answer.count > 0 ? answer[0] : ""
                cell.setText(text: previousAnswer)
                
                return cell
            
            case "Numeric":
                let cell = tableView.dequeueReusableCell(withIdentifier: "NumericTVC", for: indexPath) as? NumericTVC ?? NumericTVC()
                cell.delegate = self
                
                let previousAnswer = answer.count > 0 ? answer[0] : ""
                cell.setText(text: previousAnswer)
                
                return cell
                
            case "Grid":
                let cell = tableView.dequeueReusableCell(withIdentifier: "GridSatisfyTVC", for: indexPath) as? GridSatisfyTVC ?? GridSatisfyTVC()
                //cell.delegate = self
                //let previousAnswer = answer.count > 0 ? answer[0] : ""
                //cell.setText(text: previousAnswer)
                
                return cell
        
            default:
                let cell = UITableViewCell()
                return cell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (question?.answerType ?? "" == "MCQ") {
            if (answer.contains(question?.answerChoices?[indexPath.row] ?? "")) {
                answer.remove(at: answer.firstIndex(where: { $0 == question?.answerChoices?[indexPath.row] ?? ""}) ?? -1)
            }
            else{
                answer.append(question?.answerChoices?[indexPath.row] ?? "")
            }
        }
    
        if (question?.answerType ?? "" == "BCQ") {
            answer = []
            answer.append(question?.answerChoices?[indexPath.row] ?? "")
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterTVC") as? FooterTVC ?? FooterTVC()
        cell.delegate = self
        
        questionNumber == 1 ? cell.setPreviousBtnInactive() : cell.setPreviousBtnActive()
        if (questionNumber == module?.questions?.count) {
            cell.setNextBtnToProceed()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
       
       
}

extension QuestionVC : FooterTVCDelegate {
    func submitBtnTapped() {
        
        module?.isCompleted = true
        saveAnswerInCoreData()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ModuleCompletedVC") as? ModuleCompletedVC ?? ModuleCompletedVC()
        viewController.module = module
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func nextBtnTapped() {
        
        //Write Answer To FireStore
        
       
        //writeAnswerToFirestore()
        
        saveAnswerInCoreData()
        
        let questions = module?.questions?.allObjects as? [Question]
        
        if (question?.skipLogic == true && answer.count > 0) {
            let nextQuestionId = question?.skipAnswer == answer[0] ? question?.skipToQuestionId : question?.nextQuestionId
            let nextQuestion = questions?.first(where: {$0.questionId == nextQuestionId})
            pushNewQuestionVC(question: nextQuestion, questionNumber: nextQuestionId)
        }
        else {
            let nextQuestionId = question?.nextQuestionId
            let nextQuestion = questions?.first(where: {$0.questionId == nextQuestionId})
            pushNewQuestionVC(question: nextQuestion, questionNumber: nextQuestionId)
        }
 
    }
    
    func previousBtnTapped() {
        print(answer)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension QuestionVC : TextTVCDelegate {
    func textFieldValueChanged(newValue: String) {
        answer = []
        answer.append(newValue)
    }
}

extension QuestionVC : NumericTVCDelegate {
    func numericFieldValueChanged(newValue: String) {
        answer = []
        answer.append(newValue)
    }
}
