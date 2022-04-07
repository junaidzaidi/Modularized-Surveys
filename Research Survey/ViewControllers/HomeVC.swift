//
//  HomeVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 28/10/2021.
//

import UIKit

class HomeVC: UIViewController {

 
    //MARK:- IBOutlets
    
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var surveyNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeView: UIView!
    //MARK:- Helper Variables
    var modules : [Module]? = nil
    var surveyName = ""
    var previousAnsweredQuestionsVCs : [UIViewController] = []
    var notifyUsers: Bool = false
    var lastQuestionAnswered: [Int] = []
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proceedBtn.layer.cornerRadius = 8
        proceedBtn.clipsToBounds = true
        
        if UserDefaults.standard.bool(forKey: "InfoPresented") == true {
            informationView.isHidden = true
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(grabData),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
        
        
        let condition = UserDefaults.standard.bool(forKey: "MainHeading")
        if !condition {
            surveyNameLbl.isHidden = !condition
            surveyNameLbl.text = nil
            topConst.constant = 0
            bottomConst.constant = 0
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func grabData() {
        
        modules = Helper.modules
        let totalModules = modules?.count
        modules = modules?.filter({ $0.dateAdded! <= Date()
        })
        modules?.sort(by: { $0.dateAdded! < $1.dateAdded!
        })
        
        if(totalModules == modules?.count) {
            notifyUsers = false
        }
        
        DispatchQueue.main.async {
            self.homeView.dropShadow()
            self.tableView.reloadData()
        }
        surveyNameLbl.text = surveyName
        lastQuestionAnswered = []
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        
        modules = Helper.modules
        let totalModules = modules?.count
        modules = modules?.filter({ $0.dateAdded! <= Date()
        })
        modules?.sort(by: { $0.dateAdded! < $1.dateAdded!
        })
        
        if(totalModules == modules?.count) {
            notifyUsers = false
        }
        
        DispatchQueue.main.async {
            self.homeView.dropShadow()
            self.tableView.reloadData()
        }
        surveyNameLbl.text = surveyName
        lastQuestionAnswered = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.view.showBlurLoader()
        
    }
    //MARK:- IBActions
    @IBAction func settingBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SettingVC") as? SettingVC ?? SettingVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func proceedBtnTapped(_ sender: UIButton) {
        informationView.isHidden = true
        UserDefaults.standard.set(true, forKey: "InfoPresented")
    }
    
    //MARK:- Helper Functions
    func setup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "HomeTVC", bundle: nil), forCellReuseIdentifier: "HomeTVC")
        tableView.register(UINib(nibName: "HomeCompletedTVC", bundle: nil), forCellReuseIdentifier: "HomeCompletedTVC")
        tableView.register(UINib(nibName: "ReleaseDateTVC", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReleaseDateTVC")
        
    }
    
    func configure() {
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (modules?[indexPath.row].isCompleted == true) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCompletedTVC", for: indexPath) as? HomeCompletedTVC ?? HomeCompletedTVC()
            lastQuestionAnswered.append(-1)
            cell.moduleNameLbl.text = modules?[indexPath.row].moduleName ?? ""
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as? HomeTVC ?? HomeTVC()
        //cell.mainView.backgroundColor = indexPath.row > 5 ? .white : UIColor(red: 178/255, green: 220/255, blue: 255/255, alpha: 0.90)
        cell.moduleName.text = modules?[indexPath.row].moduleName ?? ""
        
        /*
        let allQuestions = modules?[indexPath.row].questions?.allObjects as? [Question]
        let answeredQuestions = allQuestions?.filter({ $0.answer?.answer != nil && $0.answer?.answer?.count ?? 0 > 0
        })
        
        
        let answerCount = answeredQuestions?.max(by: { $0.questionId < $1.questionId
        })?.questionId ?? 0
        lastQuestionAnswered.append(Int(answerCount))
         */
        
        let answerCount = modules?[indexPath.row].lastQuestionAnswered ?? 0
        var questionCount = modules?[indexPath.row].questions?.count ?? 0
        if questionCount == 18 || questionCount == 16 || questionCount == 19 || questionCount == 65 {
            questionCount -= 1
        }
        cell.questionStatus.text = "\(String(describing: answerCount))/\(String(describing: questionCount))"
        
        cell.setProgressBarProgress(progress: Float(answerCount)/Float(questionCount))
        
        cell.selectionStyle = .none
        
        //modules?[indexPath.row].isCompleted ?? false ? cell.markCellCompleted() : cell.markCellDefault()
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (notifyUsers) {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReleaseDateTVC") as? ReleaseDateTVC ?? ReleaseDateTVC()
            return cell
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let questions = modules?[indexPath.row].questions?.allObjects as? [Question]
        var question = questions?.first(where: {$0.isFirst == true})
        var currentQuestionNumber = 0
        
        while (currentQuestionNumber != modules?[indexPath.row].lastQuestionAnswered ?? 0) {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
            currentQuestionNumber = Int(question!.questionId)
            viewController.module = modules?[indexPath.row]
            viewController.question = question
            viewController.questionNumber = Int(question?.questionId ?? 0)
            viewController.moduleName = modules?[indexPath.row].moduleName ?? ""
            previousAnsweredQuestionsVCs.append(viewController)
            //self.navigationController?.viewControllers.append(viewController)
            
            if (question?.skipLogic == true && question?.answer?.answer?.count ?? 0 > 0) {
                let nextQuestionId = question?.skipAnswer?.contains(question?.answer?.answer?[0] ?? "") ?? true  ? question?.skipToQuestionId : question?.nextQuestionId
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
        viewController.module = modules?[indexPath.row]
        viewController.question = question
        viewController.questionNumber = Int(question?.questionId ?? 0)
        viewController.moduleName = modules?[indexPath.row].moduleName ?? ""
        previousAnsweredQuestionsVCs.append(viewController)
        self.navigationController?.viewControllers.append(contentsOf: previousAnsweredQuestionsVCs)
        
        
        //Navigate to the not answered question
        
        //self.navigationController?.pushViewController(viewController, animated: true)
     
    }
}
