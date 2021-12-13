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
    
   
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
       super.viewDidLoad()
       setup()
       
       // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
      
       
    }
       
    override func viewWillAppear(_ animated: Bool) {
       DispatchQueue.main.async {
           self.homeView.dropShadow()
       }
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
       
        tableView.register(UINib(nibName: "MultipleChoiceTVC", bundle: nil), forCellReuseIdentifier: "MultipleChoiceTVC")
        tableView.register(UINib(nibName: "BestChoiceTVC", bundle: nil), forCellReuseIdentifier: "BestChoiceTVC")
        tableView.register(UINib(nibName: "TextTVC", bundle: nil), forCellReuseIdentifier: "TextTVC")
        tableView.register(UINib(nibName: "NumericTVC", bundle: nil), forCellReuseIdentifier: "NumericTVC")
        tableView.register(UINib(nibName: "FooterTVC", bundle: nil), forHeaderFooterViewReuseIdentifier: "FooterTVC")

    }

    func configure() {
       
    }
    
    func pushNewQuestionVC(question: Question? , questionNumber: Int?) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
        viewController.module = module
        viewController.question = question
        viewController.questionNumber = questionNumber ?? 0
        viewController.moduleName = moduleName
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension QuestionVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question?.answerChoices?.count == nil ? 1 : question?.answerChoices?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch question?.answerType ?? "" {
        
            case "MCQ":
                let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceTVC", for: indexPath) as? MultipleChoiceTVC ?? MultipleChoiceTVC()
                cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                return cell
                
        
            case "BCQ":
                let cell = tableView.dequeueReusableCell(withIdentifier: "BestChoiceTVC", for: indexPath) as? BestChoiceTVC ?? BestChoiceTVC()
                cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                return cell
            
            
            case "Text":
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextTVC", for: indexPath) as? TextTVC ?? TextTVC()
                return cell
            
            case "Numeric":
                let cell = tableView.dequeueReusableCell(withIdentifier: "NumericTVC", for: indexPath) as? NumericTVC ?? NumericTVC()
                return cell
        
            default:
                let cell = UITableViewCell()
                return cell
        }
    }

    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
       let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
       self.navigationController?.pushViewController(viewController, animated: true)
    }*/
    
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
        
    }
    
    func nextBtnTapped() {
        let nextQuestionId = question?.nextQuestionId
        let nextQuestion = module?.questions?.first(where: {$0.questionId == nextQuestionId})
        pushNewQuestionVC(question: nextQuestion, questionNumber: nextQuestionId)
    }
    
    func previousBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
