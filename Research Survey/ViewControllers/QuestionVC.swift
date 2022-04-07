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
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var ItalicLbl: UILabel!
    @IBOutlet weak var moduleStartLbl: UILabel!
    @IBOutlet weak var moduleNameLbl: UILabel!
    
    //MARK:- Helper Variables
    
    var module : Module? = nil
    var question : Question? = nil
    var moduleName = ""
    var questionNumber : Int = 0
    var answer : [String] = []
    var startTime = Date()
    var endTime = Date()
    let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var multipleAnswerType :[String] = []
    var answerCount = 0
    
   
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
        answer = question?.answer?.answer ?? []
        answerCount = answer.count
        moduleNameLbl.text = moduleName
        questionLbl.text = question?.question ?? nil
        if (question?.firebaseId == 22 || question?.firebaseId == 23) {
            Helper.setUnderlineText(forLabel: questionLbl, onText: "result of the coronavirus pandemic", labelText: question?.question ?? "")
        }
        ItalicLbl.text = question?.questionItalicText ?? nil
        var count = module?.questions?.count ?? 0
        if count == 18 || count == 65 || count == 19 {
            count -= 1
        }
        questionNumberLbl.text = "\(questionNumber)/\(count)"
       
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
        tableView.register(UINib(nibName: "TextViewTVC", bundle: nil), forCellReuseIdentifier: "TextViewTVC")
        tableView.register(UINib(nibName: "NumericTVC", bundle: nil), forCellReuseIdentifier: "NumericTVC")
        tableView.register(UINib(nibName: "GridSatisfyTVC", bundle: nil), forCellReuseIdentifier: "GridSatisfyTVC")
        tableView.register(UINib(nibName: "VoiceTVC", bundle: nil), forCellReuseIdentifier: "VoiceTVC")
        tableView.register(UINib(nibName: "DatePickerTVC", bundle: nil), forCellReuseIdentifier: "DatePickerTVC")
        
        tableView.register(UINib(nibName: "FooterTVC", bundle: nil), forHeaderFooterViewReuseIdentifier: "FooterTVC")
        
        questionLbl.font = questionLbl.font.bold
        ItalicLbl.font = ItalicLbl.font.italic
        
        moduleStartLbl.isHidden = ((question?.moduleStartInfo) == nil)
        moduleStartLbl.text = question?.moduleStartInfo
        
        self.hideKeyboardWhenTappedAround()
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
    
    func saveAnswerToFirestore() {
        if answer.count > 0 {
            let params = [
                "username": UserDefaults.standard.string(forKey: "LoggedInUsername"),
                "password": UserDefaults.standard.string(forKey: "UserPassword"),
                "module_name": moduleName,
                "grid_questions": question?.gridQuestions,
                "question": question?.question,
                "question_type": question?.answerType,
                "answer": answer,
                "start_time": startTime,
                "end_time": Date(),
                "duration": Calendar.current.dateComponents([.second], from: startTime, to: Date()).second
            ] as [String : AnyObject]
            
            //Helper.addAnswer(parameters: params)
            _ = Helper.addAnswerInQuestionCollection(parameters: params, collection: "\(String(describing: question?.firebaseId ?? 0))")
        }
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
    
    func modifyAnsweredQuestionCount() {
        module?.lastQuestionAnswered = (module?.lastQuestionAnswered ?? 0) > (Int64(Int(question!.questionId))) ? module?.lastQuestionAnswered as! Int64 : Int64(Int(question!.questionId))
    }
    
    func saveAnswer() {
        modifyAnsweredQuestionCount()
        saveAnswerInCoreData()
        saveAnswerToFirestore()
    }
    
}

extension QuestionVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if question?.answerType == "Grid" {
            return question?.gridQuestions?.count ?? 0
        }
        if question?.answerType == "TextAndVoice" {
            multipleAnswerType = ["TextView", "Voice"]
            return 2
        }
        if question?.answerType == "Numeric&Numeric" {
            multipleAnswerType = ["Numeric", "Numeric"]
            return 2
        }
        return question?.answerChoices?.count == nil ? 1 : question?.answerChoices?.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        if(question?.answerChoices?.count == nil && indexPath.row == 2) {
            
        }
        else if (indexPath.row == question?.answerChoices?.count ?? -1 + 1){
            
        }*/

        var answerType = multipleAnswerType.count > 0 ? multipleAnswerType[indexPath.row] : question?.answerType ?? ""
        
        switch answerType ?? "" {
        
            case "MCQ":
                if let contains = question?.otherOption?.contains(question?.answerChoices?[indexPath.row] ?? "-1"), contains == true {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMCQTVC", for: indexPath) as? OtherMCQTVC ?? OtherMCQTVC()
                    cell.delegate = self
                    answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActiveCheck(state: true) : cell.setActiveCheck(state: false)
                    cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                    cell.setPlaceholder(text: question?.placeholderText)
                    if (answer.contains(question?.answerChoices?[indexPath.row] ?? " ")) {
                        DispatchQueue.main.async {
                            self.tableView.scrollToBottom(isAnimated: false)
                        }
                    }
                    let index = answer.firstIndex(where: {$0.contains("-101:")}) ?? -1
                    
                    if index > 0 {
                        cell.setText(text: answer[index])
                    }
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceTVC", for: indexPath) as? MultipleChoiceTVC ?? MultipleChoiceTVC()
                cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActive(state: true) : cell.setActive(state: false)
                return cell
                
        
            case "BCQ":
                if let contains = question?.otherOption?.contains(question?.answerChoices?[indexPath.row] ?? "-1"), contains == true {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "OtherMCQTVC", for: indexPath) as? OtherMCQTVC ?? OtherMCQTVC()
                    cell.delegate = self
                    cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                    cell.setPlaceholder(text: question?.placeholderText)
                    answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActiveRadio(state: true) : cell.setActiveRadio(state: false)
                    if (answer.contains(question?.answerChoices?[indexPath.row] ?? " ")) {
                        DispatchQueue.main.async {
                            self.tableView.scrollToBottom(isAnimated: false)
                        }
                    }
                    
                    let index = answer.firstIndex(where: {$0.contains("-101:")}) ?? -1
                    
                    if index > 0 {
                        cell.setText(text: answer[index])
                    }
                    return cell
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "BestChoiceTVC", for: indexPath) as? BestChoiceTVC ?? BestChoiceTVC()
                cell.setChoiceName(name: question?.answerChoices?[indexPath.row] ?? "")
                answer.contains(question?.answerChoices?[indexPath.row] ?? " ") ? cell.setActive(state: true) : cell.setActive(state: false)
                return cell
            
            
            case "Text":
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextTVC", for: indexPath) as? TextTVC ?? TextTVC()
                
                
                cell.delegate = self
                
                let previousAnswer = answer.count > 0 ? answer[0] : nil
                cell.setPlaceholder(placeholderText: question?.placeholderText)
                cell.setText(text: previousAnswer ?? "")
                
                return cell
            
            case "TextView":
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTVC", for: indexPath) as? TextViewTVC ?? TextViewTVC()
                
                
                cell.delegate = self
                
                let previousAnswer = answer.count > 0 ? answer[0] : nil
                cell.setPlaceholder(placeholderText: question?.placeholderText)
                cell.setText(text: previousAnswer ?? "")
                
                return cell
            
            case "Date":
    
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTVC", for: indexPath) as? DatePickerTVC ?? DatePickerTVC()
                    cell.delegate = self
    
                    let previousAnswer = answer.count > 0 ? answer[0] : nil
                    cell.setPlaceholder(placeholderText: question?.placeholderText)
                    cell.setText(text: previousAnswer)
                
                return cell
            
            case "Numeric":
                let cell = tableView.dequeueReusableCell(withIdentifier: "NumericTVC", for: indexPath) as? NumericTVC ?? NumericTVC()
                cell.delegate = self
                
                if question?.answerType == "Numeric&Numeric" {
                    
                    if indexPath.row == 0 {
                        if answer.count != 2 {
                            answer.append("")
                        }
                        let previousAnswer = answer[0]
                        cell.setText(text: previousAnswer)
                        cell.setPlaceholder(placeholderText: "Hours")
                    }
                    else {
                        if answer.count != 2 {
                            answer.append("")
                        }
                        let previousAnswer = answer[1]
                        cell.setText(text: previousAnswer)
                        cell.setPlaceholder(placeholderText: "Minutes")
                    }
                    return cell
                }
                else{
                    let previousAnswer = answer.count > 0 ? answer[0] : ""
                    cell.setText(text: previousAnswer)
                    cell.setPlaceholder(placeholderText: question?.placeholderText)
                    return cell
                }
                
            case "Grid":
                let cell = tableView.dequeueReusableCell(withIdentifier: "GridSatisfyTVC", for: indexPath) as? GridSatisfyTVC ?? GridSatisfyTVC()
                cell.setLbls(labels: (question?.answerChoices)!)
                cell.cellNumber = indexPath.row
                cell.setQuestion(question: question?.gridQuestions?[indexPath.row])
                cell.delegate = self
                
                if (answerCount-1 < indexPath.row) {
                    answer.append("")
                    answerCount += 1
                    //cell.clearAnswers()
                } else {
                    cell.setAnswer(index: question?.answerChoices?.firstIndex(where: {$0 == answer[indexPath.row]}) ?? -1)
                }
                return cell
                
            case "Voice":
                let cell = tableView.dequeueReusableCell(withIdentifier: "VoiceTVC", for: indexPath) as? VoiceTVC ?? VoiceTVC()
                    cell.delegate = self
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
        if (questionNumber == module?.questions?.count || (module?.questions?.count == 18 && questionNumber == 17) || (module?.questions?.count == 16 && questionNumber == 15) || (module?.questions?.count == 19 && questionNumber == 18) || (module?.questions?.count == 65 && questionNumber == 64)) {
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
        
        saveAnswer()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ModuleCompletedVC") as? ModuleCompletedVC ?? ModuleCompletedVC()
        viewController.module = module
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func nextBtnTapped() {
        
        saveAnswer()
        
        let questions = module?.questions?.allObjects as? [Question]
        
        if (question?.skipLogic == true && answer.count > 0) {
            let firebaseId = question?.skipAnswer?.contains(answer[0]) ?? true ? 69 : 68
            let nextQuestion = questions?.first(where: {$0.firebaseId == firebaseId})
            pushNewQuestionVC(question: nextQuestion, questionNumber: nextQuestion?.questionId)
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

extension QuestionVC : TextViewTVCDelegate {
    func textViewValueChanged(newValue: String) {
        answer = []
        answer.append(newValue)
    }
}

extension QuestionVC : GridSatisfyTVCDelegate {
    func optionValueChanged(newValue: String, cellNumber: Int) {
        answer[cellNumber] = newValue
    }
    
    
}

extension QuestionVC : DatePickerTVCDelegate {
    func dateFieldValueChanged(newValue: String) {
        answer = []
        answer.append(newValue)
    }
}

extension QuestionVC : NumericTVCDelegate {
    func numericFieldValueChanged(newValue: String, placeholder: String) {
        if (question?.answerType == "Numeric&Numeric") {
            if (placeholder == "Hours") {
                answer[0] = newValue
            }
            if (placeholder == "Minutes") {
                answer[1] = newValue
            }
        }
        else {
            answer = []
            answer.append(newValue)
        }
    }
}

extension QuestionVC : VoiceTVCDelegate {
    func voiceTextValueChanged(newValue: String) {
        answer = []
        answer.append(newValue)
    }
}

extension QuestionVC : otherTVCDelegate {
    func otherTextChanged(newValue: String) {
        
        let index = answer.firstIndex(where: {$0.contains("-101:")}) ?? -1
        
        if index > 0 {
            answer[index] = newValue
        }
        else {
            answer.append(newValue)
        }
    }
}
