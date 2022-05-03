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
    
    @IBOutlet weak var showPasswordImgView: UIImageView!
    
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

        self.hideKeyboardWhenTappedAround()
        if((UserDefaults.standard.string(forKey: "LoggedInUsername")) != nil) {
            Helper.startDate = Date()
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
    
    @IBAction func showPasswordTapped(_ sender: UIButton) {
        if showPasswordImgView.image == UIImage(systemName: "eye") {
            
            DispatchQueue.main.async {
                self.showPasswordImgView.image = UIImage(systemName: "eye.slash")
                self.passwordTxtFld.isSecureTextEntry = false

            }
        }
        else {
            DispatchQueue.main.async {
                self.showPasswordImgView.image = UIImage(systemName: "eye")
                self.passwordTxtFld.isSecureTextEntry = true
            }
        }
    }
    
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
                case "1ahkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(true, forKey: "NotifyUsers")
                    UserDefaults.standard.set("a",forKey: "VoiceCondition")
                    UserDefaults.standard.set("1",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//                        guard error == nil else {
//                            print("Error creating notification")
//                            //return
//                        }
                        self.createCoreDataWithNotifyModules()
                    }
                case "1bhkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(true, forKey: "NotifyUsers")
                    UserDefaults.standard.set("b",forKey: "VoiceCondition")
                    UserDefaults.standard.set("1",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//                        guard error == nil else {
//                            print("Error creating notification")
//                            //return
//                        }
                        self.createCoreDataWithNotifyModules()
                    }
                case "1chkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(true, forKey: "NotifyUsers")
                    UserDefaults.standard.set("c",forKey: "VoiceCondition")
                    UserDefaults.standard.set("1",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//                        guard error == nil else {
//                            print("Error creating notification")
//                            //return
//                        }
                        self.createCoreDataWithNotifyModules()
                    }
                case "1dhkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(true, forKey: "NotifyUsers")
                    UserDefaults.standard.set("d",forKey: "VoiceCondition")
                    UserDefaults.standard.set("1",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//                        guard error == nil else {
//                            print("Error creating notification")
//                            //return
//                        }
                        self.createCoreDataWithNotifyModules()
                    }
                case "2ahkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("a",forKey: "VoiceCondition")
                    UserDefaults.standard.set("2",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    createCoreDataWithAllModules()
                case "2bhkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("b",forKey: "VoiceCondition")
                    UserDefaults.standard.set("2",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    createCoreDataWithAllModules()
                case "2chkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("c",forKey: "VoiceCondition")
                    UserDefaults.standard.set("2",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    createCoreDataWithAllModules()
                case "2dhkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("d",forKey: "VoiceCondition")
                    UserDefaults.standard.set("2",forKey: "AppCondition")
                    UserDefaults.standard.set(true,forKey: "MainHeading")
                    createCoreDataWithAllModules()
                case "3ahkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("a",forKey: "VoiceCondition")
                    UserDefaults.standard.set("3",forKey: "AppCondition")
                    UserDefaults.standard.set(false,forKey: "MainHeading")
                    createCoreDataWithOneModule()
                case "3bhkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("b",forKey: "VoiceCondition")
                    UserDefaults.standard.set("3",forKey: "AppCondition")
                    UserDefaults.standard.set(false,forKey: "MainHeading")
                    
                    createCoreDataWithOneModule()
                    
                case "3chkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("c",forKey: "VoiceCondition")
                    UserDefaults.standard.set("3",forKey: "AppCondition")
                    UserDefaults.standard.set(false,forKey: "MainHeading")
                    createCoreDataWithOneModule()
                    
                case "3dhkdso":
                    self.view.showBlurLoader()
                    UserDefaults.standard.set(usernameTxtFld.text!, forKey: "LoggedInUsername")
                    UserDefaults.standard.set(password, forKey: "UserPassword")
                    UserDefaults.standard.set(false, forKey: "NotifyUsers")
                    UserDefaults.standard.set("d",forKey: "VoiceCondition")
                    UserDefaults.standard.set("3",forKey: "AppCondition")
                    UserDefaults.standard.set(false,forKey: "MainHeading")
                    createCoreDataWithOneModule()
                    
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
        
        let condition = UserDefaults.standard.string(forKey: "VoiceCondition")
        let appCondition = UserDefaults.standard.string(forKey: "AppCondition")
        let newModule1 = Module(context: self.coreDataContext)
        newModule1.dateAdded = Calendar.current.date(byAdding: .minute, value: -8, to: Date())
        newModule1.moduleName = "General Economic Survey"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.firebaseId = 1
        question1.nextQuestionId = 2
        question1.question = "During the week of April 25, 2022, who was your principal employer?"
        question1.questionItalicText = "If you had more than one job, report the one for which you worked the most hours that week.\nIf you worked for a contracting or consulting company, report the name of that company, not the client organization."
        question1.placeholderText = "Employer Name"
        question1.answerType = "Text"
        question1.isFirst = true
        question1.module = newModule1
        question1.moduleStartInfo = "The questions in this section are about your principal employer. Please read each question carefully and provide an answer."
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.firebaseId = 2
        question2.nextQuestionId = 3
        question2.question = "Which one of the following best describes your principal employer during the week of April 25, 2022?"
        question2.answerType = "BCQ"
        question2.answerChoices = [
            "SELF EMPLOYED OR A BUSINESS OWNER in a non-incorporated business, professional practice, or farm",
            "SELF EMPLOYED OR A BUSINESS OWNER in an incorporated business, professional practice, or farm",
            "PRIVATE SECTOR employee in a for-profit company or organization",
            "PRIVATE SECTOR employee in a non-profit organization (including private colleges/universities)",
            "GOVERNMENT employee in a local government (e.g., city, county, school district)",
            "GOVERNMENT employee in a state government (including state colleges/universities)",
            "GOVERNMENT employee in the U.S. military service, active duty or Commissioned Corps (e.g., USPHS, NOAA)",
            "GOVERNMENT employee in the U.S. Federal government (e.g., civilian employee)",
            "Another type of employee"]
        question2.otherOption = ["Another type of employee"]
        question2.placeholderText = "Specify"
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.firebaseId = 3
        question3.nextQuestionId = 4
        question3.question = "What was that employer’s main business or industry – that is, what did that employer make or do?"
        question3.questionItalicText = "If your principal employer had more than one type of business, report the type of business primarily performed at the location where you worked.\nExample: Production of microprocessor chips"
        question3.placeholderText = "EMPLOYER’S MAIN BUSINESS"
        question3.answerType = "Text"
        question3.module = newModule1
        
        let question4 = Question(context: self.coreDataContext)
        question4.questionId = 4
        question4.firebaseId = 4
        question4.nextQuestionId = 5
        question4.question = "Counting all locations where this employer operates, how many people work for your principal employer? Your best estimate is fine."
        question4.answerType = "BCQ"
        question4.answerChoices = ["10 or fewer employees",
                                    "11 – 24 employees",
                                    "25 – 99 employees",
                                    "100 – 499 employees",
                                    "500 – 999 employees",
                                    "1,000 – 4,999 employees",
                                    "5,000 – 24,999 employees",
                                    "25,000 or more employees"]
        question4.module = newModule1
        
        let question5 = Question(context: self.coreDataContext)
        question5.questionId = 5
        question5.firebaseId = 5
        question5.nextQuestionId = 6
        question5.question = "Was your principal employer established as a new business within the past 5 years?"
        question5.answerType = "BCQ"
        question5.answerChoices = ["Yes",
                                    "No"]
        question5.module = newModule1
        
        let question6 = Question(context: self.coreDataContext)
        question6.questionId = 6
        question6.nextQuestionId = 7
        question6.firebaseId = 6
        question6.question = "Was your principal employer an educational institution?"
        question6.answerType = "BCQ"
        question6.answerChoices = ["Yes",
                                    "No"]
        question6.module = newModule1
        
        
        let question21 = Question(context: self.coreDataContext)
        question21.questionId = 7
        question21.firebaseId = 7
        question21.nextQuestionId = 8
        question21.question = "During the week of April 25, 2022, what was the title of the principal job you held?"
        question21.questionItalicText = "Example: Financial Analyst"
        question21.answerType = "Text"
        question21.module = newModule1
        question21.moduleStartInfo = "This section has questions about your job duties and salary. Please read each question carefully and provide an answer."
        
        let question22 = Question(context: self.coreDataContext)
        question22.questionId = 8
        question22.firebaseId = 8
        question22.nextQuestionId = 9
        question22.question = "What kind of work were you doing on this job – that is, what were your duties and responsibilities on your principal job? Please be as specific as possible, including any area of specialization."
        question22.questionItalicText = "Examples: Analyzed financial information, prepared technical reports, specialized in asset management."
        question22.answerType = "TextView"
        question22.module = newModule1
        
        let question23 = Question(context: self.coreDataContext)
        question23.questionId = 9
        question23.firebaseId = 9
        question23.nextQuestionId = 10
        question23.question = "Did your duties on this job require the technical expertise of a bachelor’s degree or higher in engineering, computer science, math, or the natural sciences?"
        question23.answerType = "BCQ"
        question23.answerChoices = ["Yes",
                                    "No"]
        question23.module = newModule1
        
        let question24 = Question(context: self.coreDataContext)
        question24.questionId = 10
        question24.firebaseId = 10
        question24.nextQuestionId = 11
        question24.question = "Did your duties on this job require the technical expertise of a bachelor’s degree or higher in the social sciences?"
        question24.answerType = "BCQ"
        question24.answerChoices = ["Yes",
                                    "No"]
        question24.module = newModule1
        
        let question25 = Question(context: self.coreDataContext)
        question25.questionId = 11
        question25.firebaseId = 11
        question25.nextQuestionId = 12
        question25.question = "During what month and year did you start this job (that is, the principal job you held during the week of April 25, 2022)?"
        //question25.questionItalicText = "Principal job started??? Date Time??"
        question25.answerType = "Date"
        question25.placeholderText = "Principal job started"
        question25.module = newModule1
        
        let question26 = Question(context: self.coreDataContext)
        question26.questionId = 12
        question26.firebaseId = 12
        question26.nextQuestionId = 13
        question26.question = "The next question is about your work activities on your principal job. Which of the following work activities occupied at least 10 percent of your time during a typical work week on this job?"
        question26.questionItalicText = "Check all that apply"
        question26.answerType = "MCQ"
        question26.answerChoices = ["Accounting, finance, contracts",
                                    "Basic research – study directed toward gaining scientific knowledge primarily for its own sake",
                                    "Applied research – study directed toward gaining scientific knowledge to meet a recognized need",
                                    "Development – using knowledge gained from research for the production of materials, devices",
                                    "Design of equipment, processes, structures, models",
                                    "Computer programming, systems, or applications development",
                                    "Human resources – including recruiting, personnel development, training",
                                    "Managing or supervising people or projects",
                                    "Production, operations, maintenance (e.g., chip production, operating lab equipment)",
                                    "Professional services (e.g., health care, counseling, financial services, legal services)",
                                    "Sales, purchasing, marketing, customer service, public relations",
                                    "Quality or productivity management",
                                    "Teaching",
                                    "Other activity"]
        question26.otherOption = ["Other activity"]
        question26.placeholderText = "Specify"
        
        question26.module = newModule1
        
        let question27 = Question(context: self.coreDataContext)
        question27.questionId = 13
        question27.firebaseId = 13
        question27.nextQuestionId = 14
        question27.question = "On which activity did you work the most hours during a typical week on this job?"
        question27.questionItalicText = "Select the activity in which you worked the most hours from the list."
        question27.answerType = "BCQ"
        question27.answerChoices = ["Accounting, finance, contracts",
                                    "Basic research – study directed toward gaining scientific knowledge primarily for its own sake",
                                    "Applied research – study directed toward gaining scientific knowledge to meet a recognized need",
                                    "Development – using knowledge gained from research for the production of materials, devices",
                                    "Design of equipment, processes, structures, models",
                                    "Computer programming, systems, or applications development",
                                    "Human resources – including recruiting, personnel development, training",
                                    "Managing or supervising people or projects",
                                    "Production, operations, maintenance (e.g., chip production, operating lab equipment)",
                                    "Professional services (e.g., health care, counseling, financial services, legal services)",
                                    "Sales, purchasing, marketing, customer service, public relations",
                                    "Quality or productivity management",
                                    "Teaching",
                                    "Other activity"]
        question27.otherOption = ["Other activity"]
        question27.placeholderText = "Specify"
        question27.module = newModule1
        
        
        let question28 = Question(context: self.coreDataContext)
        question28.questionId = 14
        question28.firebaseId = 14
        question28.nextQuestionId = 15
        question28.question = "As part of the principal job you held during the week of April 25, 2022, did you supervise the work of others?"
        question28.questionItalicText = "Mark “Yes” if you recommended or initiated personnel actions such as hiring, firing, evaluating, or promoting others.\nTeachers: Do not count students."
        question28.answerType = "BCQ"
        question28.answerChoices = ["Yes",
                                    "No"]
        question28.module = newModule1
        
        let question29 = Question(context: self.coreDataContext)
        question29.questionId = 15
        question29.firebaseId = 15
        question29.nextQuestionId = 16
        question29.question = "During a typical week on your principal job, how many hours did you work?"
        question29.answerType = "Numeric"
        question29.placeholderText = "Number of hours worked per week"
        question29.module = newModule1
        
        let question210 = Question(context: self.coreDataContext)
        question210.questionId = 16
        question210.firebaseId = 16
        question210.nextQuestionId = 17
        question210.question = "As of the week of April 25, 2022, what was your basic annual salary on your principal job, before deductions?"
        question210.questionItalicText = "Do not include bonuses, overtime, or additional compensation for summertime teaching or research. If you are not salaried, please estimate your earned income, excluding business expenses."
        question210.answerType = "Numeric"
        question210.placeholderText = "$"
        question210.module = newModule1
        
        let question211 = Question(context: self.coreDataContext)
        question211.questionId = 17
        question211.firebaseId = 17
        question211.nextQuestionId = 18
        question211.question = "Was this salary based on a 52-week year, or less than that?"
        question211.questionItalicText = "Include paid vacation and sick leave."
        question211.answerType = "BCQ"
        question211.answerChoices = ["52-week year",
                                    "Less than 52 weeks"]
        question211.placeholderText = "Number of weeks per year"
        question211.otherOption = ["Less than 52 weeks"]
        question211.module = newModule1
        
        let question212 = Question(context: self.coreDataContext)
        question212.questionId = 18
        question212.nextQuestionId = 19
        question212.firebaseId = 18
        question212.question = "Please indicate how much you agree or disagree with the following statements about balancing your professional and personal responsibilities in your current position."
        question212.questionItalicText = "Select one answer for each question."
        question212.gridQuestions = ["Your current position is stressful.",
                                     "You can manage the demands of your position.",
                                     "Your work schedule allows you to maintain your overall quality of life.",
                                     "Your supervisor understands when demands at home interfere with your professional responsibilities",
                                     "Demands at home have slowed down progress on your professional activities."]
        question212.answerType = "Grid"
        question212.answerChoices = ["Strongly agree",
                                    "Somewhat agree",
                                    "Somewhat disagree",
                                    "Strongly disagree"]
        
        question212.placeholderText = "Number of weeks per year"
        question212.module = newModule1
        
        let question31 = Question(context: self.coreDataContext)
        question31.questionId = 19
        question31.firebaseId = 19
        question31.nextQuestionId = 20
        question31.question = "Thinking about the principal job you held during the week of April 25, 2022, how would you rate your overall satisfaction?"
        question31.answerType = "BCQ"
        question31.answerChoices = [
            "Very satisfied",
            "Somewhat satisfied",
            "Somewhat dissatisfied",
            "Very dissatisfied"
        ]
        question31.module = newModule1
        question31.moduleStartInfo = "The questions in this section are about your job satisfaction and how the pandemic has affected your work."
        
        
        
        let question32 = Question(context: self.coreDataContext)
        question32.questionId = 20
        question32.firebaseId = 20
        question32.nextQuestionId = 21
        question32.question = "Thinking about the principal job you held during the week of April 25, 2022, how satisfied or dissatisfied were you with the following aspects of the job?"
        question32.gridQuestions = ["Salary",
                                    "Benefits",
                                    "Job security",
                                    "Job location",
                                    "Opportunities for advancement",
                                    "Intellectual challenge",
                                    "Level of responsibility",
                                    "Degree of independence",
                                    "Contribution to society"]
        question32.questionItalicText = "Select one answer for each question."
        question32.answerType = "Grid"
        question32.answerChoices = [
            "Very satisfied",
            "Somewhat satisfied",
            "Somewhat dissatisfied",
            "Very dissatisfied"
            ]
        question32.module = newModule1
        
        let question33 = Question(context: self.coreDataContext)
        question33.questionId = 21
        question33.firebaseId = 21
        question33.nextQuestionId = 22
        question33.question = "For the principal job you held during the week of April 25, 2022, has your basic annual salary been affected at any time by the coronavirus pandemic?"
        question33.answerType = "BCQ"
        question33.answerChoices = ["Yes",
                                    "No"]
        question33.module = newModule1
        
        let question34 = Question(context: self.coreDataContext)
        question34.questionId = 22
        question34.firebaseId = 22
        question34.nextQuestionId = 23
        question34.question = "In general, how has your work been affected as a result of the coronavirus pandemic?"
        question34.answerType = "TextView"
        //question34.placeholderText = "Define"
        question34.module = newModule1
        
        let question35 = Question(context: self.coreDataContext)
        question35.questionId = 23
        question35.nextQuestionId = 24
        question35.firebaseId = 23
        question35.question = "In general, how have your career plans been affected as a result of the coronavirus pandemic?"
        question35.answerType = "TextView"
        //question35.placeholderText = "Define"
        question35.module = newModule1
        
        
        let question41 = Question(context: self.coreDataContext)
        question41.questionId = 24
        question41.firebaseId = 24
        question41.nextQuestionId = 25
        question41.question = "Thinking of your principal job during the week of April 25, 2022, which of the following benefits were available to you, even if you chose not to take them?"
        question41.questionItalicText = "Check all that apply"
        question41.answerType = "MCQ"
        question41.answerChoices = ["Health insurance that was at least partially paid by your employer",
                                    
                                    "BA pension plan or a retirement plan to which your employer contributed",
                                    "A profit-sharing plan",
                                    "New or additional paid leave due to the coronavirus pandemic",
                                    "Paid vacation, sick or personal days unrelated to the coronavirus pandemic"]
        question41.module = newModule1
        question41.moduleStartInfo = "This section focuses on your job benefits and security. Please read each question carefully and provide an answer. "
        
        let question42 = Question(context: self.coreDataContext)
        question42.questionId = 25
        question42.firebaseId = 25
        question42.nextQuestionId = 26
        question42.question = "Thinking of your principal job during the week of April 25, 2022, which of the following best describes whether you were allowed or required to telecommute/work remotely?"
        question42.answerType = "BCQ"
        question42.answerChoices = ["I was allowed or required to telecommute/work remotely due to the coronavirus pandemic",
                                    "I was allowed or required to telecommute/work remotely regardless of the coronavirus pandemic",
                                    "I was not allowed or required to telecommute/work remotely",
                                    "Telecommuting/working remotely did not make sense for my job"]
        question42.module = newModule1
        
        let question43 = Question(context: self.coreDataContext)
        question43.questionId = 26
        question43.firebaseId = 26
        question43.nextQuestionId = 27
        question43.question = "Thinking back now to 2021 was any of your work during 2021 supported by contracts or grants from the U.S. Federal Government?"
        question43.questionItalicText = "Federal employees: Please answer “No.“"
        question43.answerType = "BCQ"
        question43.answerChoices = ["Did not work in 2021",
                                    "Yes",
                                    "No",
                                    "Don’t know"]
        question43.module = newModule1
        
        let question44 = Question(context: self.coreDataContext)
        question44.questionId = 27
        question44.firebaseId = 27
        question44.nextQuestionId = 28
        question44.question = "Please indicate how much you agree or disagree with the following statements about your current position."
        question44.questionItalicText = "Select one answer for each question."
        question44.gridQuestions = ["I have a mentor who I can rely on for career advice.",
                                    "I am given a high degree of independence.",
                                    "I have an opportunity to take work-related trainings, such as workshops or seminars.",
                                    "I am paid fairly for the work I do.",
                                    "I have opportunities for promotion or advancement in your current occupation."]

        question44.answerType = "Grid"
        question44.answerChoices = ["Strongly agree",
                                    "Somewhat agree",
                                    "Somewhat disagree",
                                    "Strongly disagree"]
        question44.module = newModule1
        
        let question45 = Question(context: self.coreDataContext)
        question45.questionId = 28
        question45.firebaseId = 28
        question45.nextQuestionId = 29
        question45.question = "Thinking about the next 12 months, how likely do you think it is that you will lose your job or be laid off?"
        question45.answerType = "BCQ"
        question45.answerChoices = ["Very likely",
                                    "Fairly likely",
                                    "Not too likely",
                                    "Not at all likely"]
        question45.module = newModule1
        
//        let question46 = Question(context: self.coreDataContext)
//        question46.questionId = 29
//        question46.firebaseId = 29
//        question46.nextQuestionId = 30
//        question46.question = "Could you tell us why you say that?"
//        question46.answerType = "TextView"
//        //question46.placeholderText = "Specify"
//        question46.module = newModule1
        
        let question47 = Question(context: self.coreDataContext)
        question47.questionId = 29
        question47.firebaseId = 30
        question47.nextQuestionId = 30
        question47.question = "About how easy would it be for you to find a job with another employer with approximately the same income and fringe benefits you now have?"
        question47.answerType = "BCQ"
        question47.answerChoices = ["Very likely",
                                    "Fairly likely",
                                    "Not too likely",
                                    "Not at all likely"]
        question47.module = newModule1
        
        
//        let question48 = Question(context: self.coreDataContext)
//        question48.questionId = 31
//        question48.firebaseId = 31
//        question48.nextQuestionId = 32
//        question48.question = "Could you tell us why you say that?"
//        question48.answerType = "TextView"
//        //question48.placeholderText = "Specify"
//        question48.module = newModule1
        
        let question49 = Question(context: self.coreDataContext)
        question49.questionId = 30
        question49.firebaseId = 32
        question49.nextQuestionId = 31
        question49.question = "As of April 25, 2022, did you have any active professional certifications or state or industry licenses?"
        question49.questionItalicText = "A professional certification or license shows you are qualified to perform a specific job. Only include certifications or licenses obtained by an individual. Examples include Certified Teacher, Registered Nurse, Licensed Professional Engineer, a Project Management certification, or an IT certification.\nDo not include licenses needed by a business to operate."
        question49.answerType = "BCQ"
        question49.answerChoices = ["Yes",
                                    "No"]
        question49.module = newModule1
        
        let question410 = Question(context: self.coreDataContext)
        question410.questionId = 31
        question410.firebaseId = 33
        question410.nextQuestionId = 32
        question410.question = "During the past 12 months, did you take any work-related training, such as workshops or seminars?"
        question410.questionItalicText = "Include conferences or professional meetings only if you attended a training session at the conference or meeting.\nDo not include college coursework for which you were enrolled in a degree program."
        question410.answerType = "BCQ"
        question410.answerChoices = ["Yes",
                                    "No"]
        question410.module = newModule1
        
        let question411 = Question(context: self.coreDataContext)
        question411.questionId = 32
        question411.firebaseId = 34
        question411.nextQuestionId = 33
        question411.question = "During the past 12 months, did you attend any professional conferences or professional society or association meetings?"
        question411.questionItalicText = "Include regional, national, or international meetings."
        question411.answerType = "BCQ"
        question411.answerChoices = ["Yes. I attended in person or virtually (i.e., online or by remote access)",
                                    "No"]
        question411.module = newModule1
        
        let question412 = Question(context: self.coreDataContext)
        question412.questionId = 33
        question412.nextQuestionId = 34
        question412.firebaseId = 35
        question412.question = "To how many regional, national, or international professional societies or associations do you currently belong?"
        question412.answerType = "Numeric"
        question412.questionItalicText = "If none, enter “0.”"
        question412.placeholderText = "Number"
        question412.module = newModule1
        
        let question51 = Question(context: self.coreDataContext)
        question51.questionId = 34
        question51.firebaseId = 36
        question51.nextQuestionId = 35
        question51.question = "When thinking about a job, how important is each of the following factors to you?"
        question51.questionItalicText = "Select one answer for each question."
        question51.gridQuestions = ["Salary",
                                    "Benefits",
                                    "Job security",
                                    "Job location",
                                    "Opportunities for advancement",
                                    "Intellectual challenge",
                                    "Level of responsibility",
                                    "Degree of independence",
                                    "Contribution to society"]
        question51.answerType = "Grid"
        question51.answerChoices = [
            "Very important",
            "Somewhat important",
            "Somewhat unimportant",
            "Very unimportant"
        ]
        question51.module = newModule1
        question51.moduleStartInfo = "The questions in this section about your job expectations and financial situation."
        
        
        
        let question52 = Question(context: self.coreDataContext)
        question52.questionId = 35
        question52.firebaseId = 37
        question52.nextQuestionId = 36
        question52.question = "We are interested in how people are getting along financially these days. So far as you and your family are concerned, would you say that you are pretty well satisfied with your present financial situation, more or less satisfied, or not satisfied at all?"
        question52.answerType = "BCQ"
        question52.answerChoices = [
            "Pretty well satisfied",
            "More or less satisfied",
            "Not satisfied at all"]
        question52.module = newModule1
        
        let question53 = Question(context: self.coreDataContext)
        question53.questionId = 36
        question53.firebaseId = 38
        question53.nextQuestionId = 37
        question53.question = "Could you tell us a little more about that?"
        question53.answerType = "TextView"
        //question53.placeholderText = "Specify"
        question53.module = newModule1
        
        let question54 = Question(context: self.coreDataContext)
        question54.questionId = 37
        question54.firebaseId = 39
        question54.nextQuestionId = 38
        question54.question = "Compared with American families in general, would you say your family income is--far below average, below average, average, above average, or far above average? If you are uncertain, just give us your best guess."
        question54.answerType = "BCQ"
        question54.answerChoices = [
            "Far below average",
            "Below average",
            "Average",
            "Above average",
            "Far above average"]
        question54.module = newModule1
        
        let question55 = Question(context: self.coreDataContext)
        question55.questionId = 38
        question55.firebaseId = 40
        question55.nextQuestionId = 39
        question55.question = "Some people say that people get ahead by their own hard work; others say that lucky breaks or help from other people are more important. Which do you think is most important?"
        question55.answerType = "BCQ"
        question55.answerChoices = [
            "Hard work most important",
            "Hard work, luck equally important",
            "Luck or help from other people most important"
        ]
        question55.module = newModule1
        
        let question56 = Question(context: self.coreDataContext)
        question56.questionId = 39
        question56.nextQuestionId = 40
        question56.firebaseId = 41
        question56.question = "Why do you say that?"
        question56.answerType = "TextView"
        //question56.placeholderText = "Specify"
        question56.module = newModule1
        
        let question61 = Question(context: self.coreDataContext)
        question61.questionId = 40
        question61.firebaseId = 42
        question61.nextQuestionId = 41
        question61.question = "We would like to ask you about your expectations for America’s economy in the year ahead. We are going to list some indicators related to the economy. For each one we would like you to tell us whether you think during the next twelve months it will go up, go down, or stay about the same compared to now?"
        
        question61.questionItalicText = "Select one answer for each question."
        question61.answerType = "Grid"
        question61.gridQuestions = ["Unemployment",
                                    "Interest rates for borrowing money",
                                    "Prices in general",
                                    "Prices of major household items (e.g., furniture, refrigerator, stove, television)",
                                    "Prices of vehicles (e.g., car, pickup, van)",
                                    "Price of gasoline",
                                    "Availability of affordable housing",
                                    "Stock market",
                                    "Average income in the country as a whole"
                                    ]
        question61.answerChoices = [
            "Go up",
            "Stay the same",
            "Go down"
        ]
        question61.module = newModule1
        question61.moduleStartInfo = "This section focuses on economic and social issues. Please read each question carefully and provide an answer."
        
        
        
        let question62 = Question(context: self.coreDataContext)
        question62.questionId = 41
        question62.firebaseId = 43
        question62.nextQuestionId = 42
        question62.question = "Do you expect that your household income will increase by more than the rate of inflation during the next five years or so?"
        question62.answerType = "BCQ"
        question62.answerChoices = [
            "Yes",
            "No"]
        question62.module = newModule1
        
        let question63 = Question(context: self.coreDataContext)
        question63.questionId = 42
        question63.firebaseId = 44
        question63.nextQuestionId = 43
        question63.question = "Please read the following statements and indicate whether you strongly agree, agree, disagree, or strongly disagree with each statement:"
        question63.questionItalicText = "Select one answer for each question."
        question63.gridQuestions = ["A working mother can establish just as warm and secure a relationship with her children as a mother who does not work.",
                                    "A preschool child is likely to suffer if his or her mother works.",
                                    "It is much better for everyone involved if the man is the achiever outside the home and the woman takes care of the home and family.",
                                    "Family life often suffers because men concentrate too much on their work.",
                                    "Employers should make special efforts to hire and promote qualified women."]
        question63.answerType = "Grid"
        question63.answerChoices = ["Strongly agree",
                                    "Agree",
                                    "Disagree",
                                    "Strongly disagree"]
        question63.module = newModule1
        
        let question64 = Question(context: self.coreDataContext)
        question64.questionId = 43
        question64.firebaseId = 45
        question64.nextQuestionId = 44
        question64.question = "Some people say that because of past discrimination, women should be given preference in hiring and promotion. Others say that such preference in hiring and promotion of women is wrong because it discriminates against men. What about your opinion - are you for or against preferential hiring and promotion of women?"
        question64.answerType = "BCQ"
        question64.answerChoices = [
            "For",
            "Against"]
        question64.module = newModule1
        
//        let question65 = Question(context: self.coreDataContext)
//        question65.questionId = 46
//        question65.firebaseId = 46
//        question65.nextQuestionId = 47
//        question65.question = "Could you tell us why you say that?"
//        question65.answerType = "TextView"
//        question65.module = newModule1
        
        let question66 = Question(context: self.coreDataContext)
        question66.questionId = 44
        question66.firebaseId = 47
        question66.nextQuestionId = 45
        question66.question = "What do you think the chances are these days that a man won't get a job or promotion while an equally or less qualified woman gets one instead?"
        question66.answerType = "BCQ"
        question66.answerChoices = [
            "Very likely",
            "Somewhat likely",
            "Somewhat unlikely",
            "Very unlikely"
        ]
        question66.module = newModule1
        
        let question67 = Question(context: self.coreDataContext)
        question67.questionId = 45
        question67.firebaseId = 48
        question67.nextQuestionId = 46
        question67.question = "What do you think the chances are these days that a woman won't get a job or promotion while an equally or less qualified man gets one instead?"
        question67.answerType = "BCQ"
        question67.answerChoices = [
            "Very likely",
            "Somewhat likely",
            "Somewhat unlikely",
            "Very unlikely"
        ]
        question67.module = newModule1
        
//        let question68 = Question(context: self.coreDataContext)
//        question68.questionId = 49
//        question68.nextQuestionId = 50
//        question68.firebaseId = 49
//        question68.question = "Could you tell us more about that?"
//        question68.answerType = "TextView"
//        question68.module = newModule1
        
        let question71 = Question(context: self.coreDataContext)
        question71.questionId = 46
        question71.firebaseId = 50
        question71.nextQuestionId = 47
        question71.question = "During the last month, how many times did you use your iPhone to watch any streaming video?"
        question71.answerType = "Numeric"
        question71.placeholderText = "Number of times"
        question71.module = newModule1
        question71.moduleStartInfo = "The next few questions are about smartphone usage."
        
        let question72 = Question(context: self.coreDataContext)
        question72.questionId = 47
        question72.firebaseId = 51
        question72.nextQuestionId = 48
        question72.question = "During the last month, how many times did you use your iPhone to make an online purchase?"
        question72.answerType = "Numeric"
        question72.placeholderText = "Number of times"
        question72.module = newModule1
        
        let question73 = Question(context: self.coreDataContext)
        question73.questionId = 48
        question73.firebaseId = 52
        question73.nextQuestionId = 49
        question73.question = "How many apps do you currently have on your iPhone, including those that came preloaded on the phone and those you downloaded yourself?"
        question73.answerType = "Numeric"
        question73.placeholderText = "Number"
        question73.module = newModule1
        
        let question74 = Question(context: self.coreDataContext)
        question74.questionId = 49
        question74.firebaseId = 53
        question74.nextQuestionId = 50
        question74.question = "During the past week, how many minutes or hours did use the apps on your iPhone?"
        question74.questionItalicText = "You can find this information on your iPhone in four steps: 1. launch the Settings app; 2. scroll down to the words \"Screen Time\" or search for \"screen time\"; 3. tap \"See All Activity\"; and 4. Tap \"Week\" at the top of the screen to see your \"Total Screen Time\" for the week. If you don't have Screen Time enabled then enter your best estimate"
        question74.answerType = "Numeric&Numeric"
        question74.placeholderText = "Hour:Minutes"
        question74.module = newModule1
        
        //Condition Wise
        let question75 = Question(context: self.coreDataContext)
        question75.questionId = 50
        question75.firebaseId = 54
        question75.nextQuestionId = 51
        question75.question = "Currently, what information sources do you usually turn to for news about current issues and events?"
        switch condition{
        case "a":
            question75.answerType = "TextView"
        case "b":
            question75.answerType = "TextView"
            question75.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question75.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question75.answerType = "Voice"
            question75.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question75.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question75.answerType = "TextAndVoice"
            question75.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question75.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
        default:
            question75.answerType = "TextView"
        }
        question75.module = newModule1
        
        let question76 = Question(context: self.coreDataContext)
        question76.questionId = 51
        question76.firebaseId = 55
        question76.nextQuestionId = 52
        question76.question = "When thinking about a job, what factors are important to you?"
        switch condition{
        case "a":
            question76.answerType = "TextView"
        case "b":
            question76.answerType = "TextView"
            question76.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question76.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question76.answerType = "Voice"
            question76.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question76.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question76.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question76.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question76.answerType = "TextAndVoice"
        default:
            question76.answerType = "TextView"
        }
        question76.placeholderText = "Specify"
        question76.module = newModule1
        
        let question77 = Question(context: self.coreDataContext)
        question77.questionId = 52
        question77.firebaseId = 56
        question77.nextQuestionId = 53
        question77.question = "In your own words, what are some lessons that humankind should learn from the coronavirus outbreak?"
        switch condition{
        case "a":
            question77.answerType = "TextView"
        case "b":
            question77.answerType = "TextView"
            question77.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question77.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question77.answerType = "Voice"
            question77.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question77.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question77.answerType = "TextAndVoice"
            question77.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question77.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            
        default:
            question77.answerType = "TextView"
        }
        question77.module = newModule1
        
        // Debreifing Question
        let question78 = Question(context: self.coreDataContext)
        question78.questionId = 53
        question78.firebaseId = 57
        question78.nextQuestionId = 54
        question78.question = "How easy or difficult was it for you to complete this study?"
        question78.answerType = "BCQ"
        question78.answerChoices = ["Very easy",
                                    "Somewhat easy",
                                    "Neither easy nor difficult",
                                    "Somewhat difficult",
                                    "Very difficult"]
        question78.module = newModule1
        question78.moduleStartInfo = "This is the final section of the study. It has questions about your experience with the study. When answering these questions, please consider all parts of the survey, from the first section to the current section."
        
        let question79 = Question(context: self.coreDataContext)
        question79.questionId = 54
        question79.firebaseId = 58
        question79.nextQuestionId = 55
        question79.question = "Why did you say that?"
        question79.answerType = "TextView"
        question79.module = newModule1
        
        
        let question710 = Question(context: self.coreDataContext)
        question710.questionId = 55
        question710.firebaseId = 59
        question710.nextQuestionId = 56
        question710.question = "How many minutes do you think that you spent on this study?"
        question710.answerType = "Numeric"
        question710.placeholderText = "Number of minutes"
        question710.module = newModule1
        
        let question711 = Question(context: self.coreDataContext)
        question711.questionId = 56
        question711.firebaseId = 60
        question711.nextQuestionId = 57
        question711.question = "Did you experience any technical difficulties with the survey? Please tell us what problems you encountered and (if applicable) how you solved them."
        question711.answerType = "TextView"
        question711.module = newModule1
        
        let question712 = Question(context: self.coreDataContext)
        question712.questionId = 57
        question712.nextQuestionId = 58
        question712.firebaseId = 61
        question712.question = "Did you do any of the following activities while completing any part of the survey? Please select all that apply."
        question712.answerType = "MCQ"
        question712.answerChoices = ["Watch TV or videos",
                                    "Listen to music",
                                    "Chat with other people (on the phone, face-to-face)",
                                    "Text with other people",
                                    "Prepare a meal, eat or drink",
                                    "Travel on foot or in a vehicle",
                                    "Idle (e.g., wait for someone, in line for an appointment)",
                                    "Other activities"]
        question712.placeholderText = "Specify"
        question712.otherOption = ["Other activities"]
        question712.module = newModule1
        
        let question713 = Question(context: self.coreDataContext)
        question713.questionId = 58
        question713.nextQuestionId = 59
        question713.firebaseId = 62
        question713.question = "Where were you when you were working on the survey? Please select all that apply."
        question713.questionItalicText = "Please consider where you were when completing all parts of the survey, from the first section to the current section."
        question713.answerType = "MCQ"
        question713.answerChoices = ["At home",
                                   "At work",
                                   "In transit",
                                   "Other location"]
        question713.otherOption = ["Other location"]
        question713.placeholderText = "Specify"
        question713.module = newModule1
        
        //Experimental Conditions
        let appVoiceCondition = "\(appCondition)\(condition)"
        
        if (appCondition == "3") {
            if (condition == "b" || condition == "c" || condition == "d") {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 59
                question717.nextQuestionId = 60
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule1
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 60
                //question718.nextQuestionId = 16
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "MCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.placeholderText = "Specify"
                question718.otherOption = ["Other reason"]
                question718.module = newModule1
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 60
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule1
            }
        }
        do {
            try coreDataContext.save()
            getModulesFromCoreDate()
        }
        catch {
            print("Error Saving Data")
        }
        
        
    }
    
    func createCoreDataWithAllModules(){
        
        let condition = UserDefaults.standard.string(forKey: "VoiceCondition")
        let appCondition = UserDefaults.standard.string(forKey: "AppCondition")
        let newModule1 = Module(context: self.coreDataContext)
        newModule1.dateAdded = Calendar.current.date(byAdding: .minute, value: -8, to: Date())
        newModule1.moduleName = "Module 1: Employer"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.firebaseId = 1
        question1.nextQuestionId = 2
        question1.question = "During the week of April 25, 2022, who was your principal employer?"
        question1.questionItalicText = "If you had more than one job, report the one for which you worked the most hours that week.\nIf you worked for a contracting or consulting company, report the name of that company, not the client organization."
        question1.placeholderText = "Employer Name"
        question1.answerType = "Text"
        question1.isFirst = true
        question1.module = newModule1
        question1.moduleStartInfo = "The questions in this section are about your principal employer. Please read each question carefully and provide an answer."
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.firebaseId = 2
        question2.nextQuestionId = 3
        question2.question = "Which one of the following best describes your principal employer during the week of April 25, 2022?"
        question2.answerType = "BCQ"
        question2.answerChoices = [
            "SELF EMPLOYED OR A BUSINESS OWNER in a non-incorporated business, professional practice, or farm",
            "SELF EMPLOYED OR A BUSINESS OWNER in an incorporated business, professional practice, or farm",
            "PRIVATE SECTOR employee in a for-profit company or organization",
            "PRIVATE SECTOR employee in a non-profit organization (including private colleges/universities)",
            "GOVERNMENT employee in a local government (e.g., city, county, school district)",
            "GOVERNMENT employee in a state government (including state colleges/universities)",
            "GOVERNMENT employee in the U.S. military service, active duty or Commissioned Corps (e.g., USPHS, NOAA)",
            "GOVERNMENT employee in the U.S. Federal government (e.g., civilian employee)",
            "Another type of employee"]
        question2.otherOption = ["Another type of employee"]
        question2.placeholderText = "Specify"
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.firebaseId = 3
        question3.nextQuestionId = 4
        question3.question = "What was that employer’s main business or industry – that is, what did that employer make or do?"
        question3.questionItalicText = "If your principal employer had more than one type of business, report the type of business primarily performed at the location where you worked.\nExample: Production of microprocessor chips"
        question3.placeholderText = "EMPLOYER’S MAIN BUSINESS"
        question3.answerType = "Text"
        question3.module = newModule1
        
        let question4 = Question(context: self.coreDataContext)
        question4.questionId = 4
        question4.firebaseId = 4
        question4.nextQuestionId = 5
        question4.question = "Counting all locations where this employer operates, how many people work for your principal employer? Your best estimate is fine."
        question4.answerType = "BCQ"
        question4.answerChoices = ["10 or fewer employees",
                                    "11 – 24 employees",
                                    "25 – 99 employees",
                                    "100 – 499 employees",
                                    "500 – 999 employees",
                                    "1,000 – 4,999 employees",
                                    "5,000 – 24,999 employees",
                                    "25,000 or more employees"]
        question4.module = newModule1
        
        let question5 = Question(context: self.coreDataContext)
        question5.questionId = 5
        question5.firebaseId = 5
        question5.nextQuestionId = 6
        question5.question = "Was your principal employer established as a new business within the past 5 years?"
        question5.answerType = "BCQ"
        question5.answerChoices = ["Yes",
                                    "No"]
        question5.module = newModule1
        
        let question6 = Question(context: self.coreDataContext)
        question6.questionId = 6
        question6.firebaseId = 6
        question6.question = "Was your principal employer an educational institution?"
        question6.answerType = "BCQ"
        question6.answerChoices = ["Yes",
                                    "No"]
        question6.module = newModule1
        
        
        let newModule2 = Module(context: self.coreDataContext)
        newModule2.dateAdded = Calendar.current.date(byAdding: .minute, value: -7, to: Date())
        newModule2.moduleName = "Module 2: Job Duties"
        
        let question21 = Question(context: self.coreDataContext)
        question21.questionId = 1
        question21.firebaseId = 7
        question21.nextQuestionId = 2
        question21.question = "During the week of April 25, 2022, what was the title of the principal job you held?"
        question21.questionItalicText = "Example: Financial Analyst"
        question21.answerType = "Text"
        question21.isFirst = true
        question21.module = newModule2
        question21.moduleStartInfo = "This section has questions about your job duties and salary. Please read each question carefully and provide an answer."
        
        let question22 = Question(context: self.coreDataContext)
        question22.questionId = 2
        question22.firebaseId = 8
        question22.nextQuestionId = 3
        question22.question = "What kind of work were you doing on this job – that is, what were your duties and responsibilities on your principal job? Please be as specific as possible, including any area of specialization."
        question22.questionItalicText = "Examples: Analyzed financial information, prepared technical reports, specialized in asset management."
        question22.answerType = "TextView"
        question22.module = newModule2
        
        let question23 = Question(context: self.coreDataContext)
        question23.questionId = 3
        question23.firebaseId = 9
        question23.nextQuestionId = 4
        question23.question = "Did your duties on this job require the technical expertise of a bachelor’s degree or higher in engineering, computer science, math, or the natural sciences?"
        question23.answerType = "BCQ"
        question23.answerChoices = ["Yes",
                                    "No"]
        question23.module = newModule2
        
        let question24 = Question(context: self.coreDataContext)
        question24.questionId = 4
        question24.firebaseId = 10
        question24.nextQuestionId = 5
        question24.question = "Did your duties on this job require the technical expertise of a bachelor’s degree or higher in the social sciences?"
        question24.answerType = "BCQ"
        question24.answerChoices = ["Yes",
                                    "No"]
        question24.module = newModule2
        
        let question25 = Question(context: self.coreDataContext)
        question25.questionId = 5
        question25.firebaseId = 11
        question25.nextQuestionId = 6
        question25.question = "During what month and year did you start this job (that is, the principal job you held during the week of April 25, 2022)?"
        //question25.questionItalicText = "Principal job started??? Date Time??"
        question25.answerType = "Date"
        question25.placeholderText = "Principal job started"
        question25.module = newModule2
        
        let question26 = Question(context: self.coreDataContext)
        question26.questionId = 6
        question26.firebaseId = 12
        question26.nextQuestionId = 7
        question26.question = "The next question is about your work activities on your principal job. Which of the following work activities occupied at least 10 percent of your time during a typical work week on this job?"
        question26.questionItalicText = "Check all that apply"
        question26.answerType = "MCQ"
        question26.answerChoices = ["Accounting, finance, contracts",
                                    "Basic research – study directed toward gaining scientific knowledge primarily for its own sake",
                                    "Applied research – study directed toward gaining scientific knowledge to meet a recognized need",
                                    "Development – using knowledge gained from research for the production of materials, devices",
                                    "Design of equipment, processes, structures, models",
                                    "Computer programming, systems, or applications development",
                                    "Human resources – including recruiting, personnel development, training",
                                    "Managing or supervising people or projects",
                                    "Production, operations, maintenance (e.g., chip production, operating lab equipment)",
                                    "Professional services (e.g., health care, counseling, financial services, legal services)",
                                    "Sales, purchasing, marketing, customer service, public relations",
                                    "Quality or productivity management",
                                    "Teaching",
                                    "Other activity"]
        question26.otherOption = ["Other activity"]
        question26.placeholderText = "Specify"
        
        question26.module = newModule2
        
        let question27 = Question(context: self.coreDataContext)
        question27.questionId = 7
        question27.firebaseId = 13
        question27.nextQuestionId = 8
        question27.question = "On which activity did you work the most hours during a typical week on this job?"
        question27.questionItalicText = "Select the activity in which you worked the most hours from the list."
        question27.answerType = "BCQ"
        question27.answerChoices = ["Accounting, finance, contracts",
                                    "Basic research – study directed toward gaining scientific knowledge primarily for its own sake",
                                    "Applied research – study directed toward gaining scientific knowledge to meet a recognized need",
                                    "Development – using knowledge gained from research for the production of materials, devices",
                                    "Design of equipment, processes, structures, models",
                                    "Computer programming, systems, or applications development",
                                    "Human resources – including recruiting, personnel development, training",
                                    "Managing or supervising people or projects",
                                    "Production, operations, maintenance (e.g., chip production, operating lab equipment)",
                                    "Professional services (e.g., health care, counseling, financial services, legal services)",
                                    "Sales, purchasing, marketing, customer service, public relations",
                                    "Quality or productivity management",
                                    "Teaching",
                                    "Other activity"]
        question27.otherOption = ["Other activity"]
        question27.placeholderText = "Specify"
        question27.module = newModule2
        
        
        let question28 = Question(context: self.coreDataContext)
        question28.questionId = 8
        question28.firebaseId = 14
        question28.nextQuestionId = 9
        question28.question = "As part of the principal job you held during the week of April 25, 2022, did you supervise the work of others?"
        question28.questionItalicText = "Mark “Yes” if you recommended or initiated personnel actions such as hiring, firing, evaluating, or promoting others.\nTeachers: Do not count students."
        question28.answerType = "BCQ"
        question28.answerChoices = ["Yes",
                                    "No"]
        question28.module = newModule2
        
        let question29 = Question(context: self.coreDataContext)
        question29.questionId = 9
        question29.firebaseId = 15
        question29.nextQuestionId = 10
        question29.question = "During a typical week on your principal job, how many hours did you work?"
        question29.answerType = "Numeric"
        question29.placeholderText = "Number of hours worked per week"
        question29.module = newModule2
        
        let question210 = Question(context: self.coreDataContext)
        question210.questionId = 10
        question210.firebaseId = 16
        question210.nextQuestionId = 11
        question210.question = "As of the week of April 25, 2022, what was your basic annual salary on your principal job, before deductions?"
        question210.questionItalicText = "Do not include bonuses, overtime, or additional compensation for summertime teaching or research. If you are not salaried, please estimate your earned income, excluding business expenses."
        question210.answerType = "Numeric"
        question210.placeholderText = "$"
        question210.module = newModule2
        
        let question211 = Question(context: self.coreDataContext)
        question211.questionId = 11
        question211.firebaseId = 17
        question211.nextQuestionId = 12
        question211.question = "Was this salary based on a 52-week year, or less than that?"
        question211.questionItalicText = "Include paid vacation and sick leave."
        question211.answerType = "BCQ"
        question211.answerChoices = ["52-week year",
                                    "Less than 52 weeks"]
        question211.placeholderText = "Number of weeks per year"
        question211.otherOption = ["Less than 52 weeks"]
        question211.module = newModule2
        
        let question212 = Question(context: self.coreDataContext)
        question212.questionId = 12
        question212.firebaseId = 18
        question212.question = "Please indicate how much you agree or disagree with the following statements about balancing your professional and personal responsibilities in your current position."
        question212.questionItalicText = "Select one answer for each question."
        question212.gridQuestions = ["Your current position is stressful.",
                                     "You can manage the demands of your position.",
                                     "Your work schedule allows you to maintain your overall quality of life.",
                                     "Your supervisor understands when demands at home interfere with your professional responsibilities",
                                     "Demands at home have slowed down progress on your professional activities."]
        question212.answerType = "Grid"
        question212.answerChoices = ["Strongly agree",
                                    "Somewhat agree",
                                    "Somewhat disagree",
                                    "Strongly disagree"]
        
        question212.placeholderText = "Number of weeks per year"
        question212.module = newModule2
        
        let newModule3 = Module(context: self.coreDataContext)
        newModule3.dateAdded = Calendar.current.date(byAdding: .minute, value: -6, to: Date())
        newModule3.moduleName = "Module 3: Job Satisfaction"
        
        let question31 = Question(context: self.coreDataContext)
        question31.questionId = 1
        question31.firebaseId = 19
        question31.nextQuestionId = 2
        question31.question = "Thinking about the principal job you held during the week of April 25, 2022, how would you rate your overall satisfaction?"
        question31.answerType = "BCQ"
        question31.answerChoices = [
            "Very satisfied",
            "Somewhat satisfied",
            "Somewhat dissatisfied",
            "Very dissatisfied"
        ]
        question31.isFirst = true
        question31.module = newModule3
        question31.moduleStartInfo = "The questions in this section are about your job satisfaction and how the pandemic has affected your work."
        
        
        
        let question32 = Question(context: self.coreDataContext)
        question32.questionId = 2
        question32.firebaseId = 20
        question32.nextQuestionId = 3
        question32.question = "Thinking about the principal job you held during the week of April 25, 2022, how satisfied or dissatisfied were you with the following aspects of the job?"
        question32.gridQuestions = ["Salary",
                                    "Benefits",
                                    "Job security",
                                    "Job location",
                                    "Opportunities for advancement",
                                    "Intellectual challenge",
                                    "Level of responsibility",
                                    "Degree of independence",
                                    "Contribution to society"]
        question32.questionItalicText = "Select one answer for each question."
        question32.answerType = "Grid"
        question32.answerChoices = [
            "Very satisfied",
            "Somewhat satisfied",
            "Somewhat dissatisfied",
            "Very dissatisfied"
            ]
        question32.module = newModule3
        
        let question33 = Question(context: self.coreDataContext)
        question33.questionId = 3
        question33.firebaseId = 21
        question33.nextQuestionId = 4
        question33.question = "For the principal job you held during the week of April 25, 2022, has your basic annual salary been affected at any time by the coronavirus pandemic?"
        question33.answerType = "BCQ"
        question33.answerChoices = ["Yes",
                                    "No"]
        question33.module = newModule3
        
        let question34 = Question(context: self.coreDataContext)
        question34.questionId = 4
        question34.firebaseId = 22
        question34.nextQuestionId = 5
        question34.question = "In general, how has your work been affected as a result of the coronavirus pandemic?"
        question34.answerType = "TextView"
        //question34.placeholderText = "Define"
        question34.module = newModule3
        
        let question35 = Question(context: self.coreDataContext)
        question35.questionId = 5
        question35.firebaseId = 23
        question35.question = "In general, how have your career plans been affected as a result of the coronavirus pandemic?"
        question35.answerType = "TextView"
        //question35.placeholderText = "Define"
        question35.module = newModule3
        
        
        let newModule4 = Module(context: self.coreDataContext)
        newModule4.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule4.moduleName = "Module 4: Job Benefits"
        
        let question41 = Question(context: self.coreDataContext)
        question41.questionId = 1
        question41.firebaseId = 24
        question41.nextQuestionId = 2
        question41.question = "Thinking of your principal job during the week of April 25, 2022, which of the following benefits were available to you, even if you chose not to take them?"
        question41.questionItalicText = "Check all that apply"
        question41.answerType = "MCQ"
        question41.answerChoices = ["Health insurance that was at least partially paid by your employer",
                                    
                                    "BA pension plan or a retirement plan to which your employer contributed",
                                    "A profit-sharing plan",
                                    "New or additional paid leave due to the coronavirus pandemic",
                                    "Paid vacation, sick or personal days unrelated to the coronavirus pandemic"]
        question41.isFirst = true
        question41.module = newModule4
        question41.moduleStartInfo = "This section focuses on your job benefits and security. Please read each question carefully and provide an answer. "
        
        let question42 = Question(context: self.coreDataContext)
        question42.questionId = 2
        question42.firebaseId = 25
        question42.nextQuestionId = 3
        question42.question = "Thinking of your principal job during the week of April 25, 2022, which of the following best describes whether you were allowed or required to telecommute/work remotely?"
        question42.answerType = "BCQ"
        question42.answerChoices = ["I was allowed or required to telecommute/work remotely due to the coronavirus pandemic",
                                    "I was allowed or required to telecommute/work remotely regardless of the coronavirus pandemic",
                                    "I was not allowed or required to telecommute/work remotely",
                                    "Telecommuting/working remotely did not make sense for my job"]
        question42.module = newModule4
        
        let question43 = Question(context: self.coreDataContext)
        question43.questionId = 3
        question43.firebaseId = 26
        question43.nextQuestionId = 4
        question43.question = "Thinking back now to 2021 was any of your work during 2021 supported by contracts or grants from the U.S. Federal Government?"
        question43.questionItalicText = "Federal employees: Please answer “No.“"
        question43.answerType = "BCQ"
        question43.answerChoices = ["Did not work in 2020",
                                    "Yes",
                                    "No",
                                    "Don’t know"]
        question43.module = newModule4
        
        let question44 = Question(context: self.coreDataContext)
        question44.questionId = 4
        question44.firebaseId = 27
        question44.nextQuestionId = 5
        question44.question = "Please indicate how much you agree or disagree with the following statements about your current position."
        question44.questionItalicText = "Select one answer for each question."
        question44.gridQuestions = ["I have a mentor who I can rely on for career advice.",
                                    "I am given a high degree of independence.",
                                    "I have an opportunity to take work-related trainings, such as workshops or seminars.",
                                    "I am paid fairly for the work I do.",
                                    "I have opportunities for promotion or advancement in your current occupation."]

        question44.answerType = "Grid"
        question44.answerChoices = ["Strongly agree",
                                    "Somewhat agree",
                                    "Somewhat disagree",
                                    "Strongly disagree"]
        question44.module = newModule4
        
        let question45 = Question(context: self.coreDataContext)
        question45.questionId = 5
        question45.firebaseId = 28
        question45.nextQuestionId = 6
        question45.question = "Thinking about the next 12 months, how likely do you think it is that you will lose your job or be laid off?"
        question45.answerType = "BCQ"
        question45.answerChoices = ["Very likely",
                                    "Fairly likely",
                                    "Not too likely",
                                    "Not at all likely"]
        question45.module = newModule4
        
//        let question46 = Question(context: self.coreDataContext)
//        question46.questionId = 6
//        question46.firebaseId = 29
//        question46.nextQuestionId = 7
//        question46.question = "Could you tell us why you say that?"
//        question46.answerType = "TextView"
//        //question46.placeholderText = "Specify"
//        question46.module = newModule4
        
        let question47 = Question(context: self.coreDataContext)
        question47.questionId = 6
        question47.firebaseId = 30
        question47.nextQuestionId = 7
        question47.question = "About how easy would it be for you to find a job with another employer with approximately the same income and fringe benefits you now have?"
        question47.answerType = "BCQ"
        question47.answerChoices = ["Very likely",
                                    "Fairly likely",
                                    "Not too likely",
                                    "Not at all likely"]
        question47.module = newModule4
        
        
//        let question48 = Question(context: self.coreDataContext)
//        question48.questionId = 8
//        question48.firebaseId = 31
//        question48.nextQuestionId = 9
//        question48.question = "Could you tell us why you say that?"
//        question48.answerType = "TextView"
//        //question48.placeholderText = "Specify"
//        question48.module = newModule4
        
        let question49 = Question(context: self.coreDataContext)
        question49.questionId = 7
        question49.firebaseId = 32
        question49.nextQuestionId = 8
        question49.question = "As of April 25, 2022, did you have any active professional certifications or state or industry licenses?"
        question49.questionItalicText = "A professional certification or license shows you are qualified to perform a specific job. Only include certifications or licenses obtained by an individual. Examples include Certified Teacher, Registered Nurse, Licensed Professional Engineer, a Project Management certification, or an IT certification.\nDo not include licenses needed by a business to operate."
        question49.answerType = "BCQ"
        question49.answerChoices = ["Yes",
                                    "No"]
        question49.module = newModule4
        
        let question410 = Question(context: self.coreDataContext)
        question410.questionId = 8
        question410.firebaseId = 33
        question410.nextQuestionId = 9
        question410.question = "During the past 12 months, did you take any work-related training, such as workshops or seminars?"
        question410.questionItalicText = "Include conferences or professional meetings only if you attended a training session at the conference or meeting.\nDo not include college coursework for which you were enrolled in a degree program."
        question410.answerType = "BCQ"
        question410.answerChoices = ["Yes",
                                    "No"]
        question410.module = newModule4
        
        let question411 = Question(context: self.coreDataContext)
        question411.questionId = 9
        question411.firebaseId = 34
        question411.nextQuestionId = 10
        question411.question = "During the past 12 months, did you attend any professional conferences or professional society or association meetings?"
        question411.questionItalicText = "Include regional, national, or international meetings."
        question411.answerType = "BCQ"
        question411.answerChoices = ["Yes. I attended in person or virtually (i.e., online or by remote access)",
                                    "No"]
        question411.module = newModule4
        
        let question412 = Question(context: self.coreDataContext)
        question412.questionId = 10
        question412.firebaseId = 35
        question412.question = "To how many regional, national, or international professional societies or associations do you currently belong?"
        question412.answerType = "Numeric"
        question412.questionItalicText = "If none, enter “0.”"
        question412.placeholderText = "Number"
        question412.module = newModule4
        
        
        let newModule5 = Module(context: self.coreDataContext)
        newModule5.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule5.moduleName = "Module 5: Job Expectations"
        
        
        let question51 = Question(context: self.coreDataContext)
        question51.questionId = 1
        question51.firebaseId = 36
        question51.nextQuestionId = 2
        question51.question = "When thinking about a job, how important is each of the following factors to you?"
        question51.questionItalicText = "Select one answer for each question."
        question51.gridQuestions = ["Salary",
                                    "Benefits",
                                    "Job security",
                                    "Job location",
                                    "Opportunities for advancement",
                                    "Intellectual challenge",
                                    "Level of responsibility",
                                    "Degree of independence",
                                    "Contribution to society"]
        question51.answerType = "Grid"
        question51.answerChoices = [
            "Very important",
            "Somewhat important",
            "Somewhat unimportant",
            "Very unimportant"
        ]
        question51.isFirst = true
        question51.module = newModule5
        question51.moduleStartInfo = "The questions in this section about your job expectations and financial situation."
        
        
        
        let question52 = Question(context: self.coreDataContext)
        question52.questionId = 2
        question52.firebaseId = 37
        question52.nextQuestionId = 3
        question52.question = "We are interested in how people are getting along financially these days. So far as you and your family are concerned, would you say that you are pretty well satisfied with your present financial situation, more or less satisfied, or not satisfied at all?"
        question52.answerType = "BCQ"
        question52.answerChoices = [
            "Pretty well satisfied",
            "More or less satisfied",
            "Not satisfied at all"]
        question52.module = newModule5
        
        let question53 = Question(context: self.coreDataContext)
        question53.questionId = 3
        question53.firebaseId = 38
        question53.nextQuestionId = 4
        question53.question = "Could you tell us a little more about that?"
        question53.answerType = "TextView"
        //question53.placeholderText = "Specify"
        question53.module = newModule5
        
        let question54 = Question(context: self.coreDataContext)
        question54.questionId = 4
        question54.firebaseId = 39
        question54.nextQuestionId = 5
        question54.question = "Compared with American families in general, would you say your family income is--far below average, below average, average, above average, or far above average? If you are uncertain, just give us your best guess."
        question54.answerType = "BCQ"
        question54.answerChoices = [
            "Far below average",
            "Below average",
            "Average",
            "Above average",
            "Far above average"]
        question54.module = newModule5
        
        let question55 = Question(context: self.coreDataContext)
        question55.questionId = 5
        question55.firebaseId = 40
        question55.nextQuestionId = 6
        question55.question = "Some people say that people get ahead by their own hard work; others say that lucky breaks or help from other people are more important. Which do you think is most important?"
        question55.answerType = "BCQ"
        question55.answerChoices = [
            "Hard work most important",
            "Hard work, luck equally important",
            "Luck or help from other people most important"
        ]
        question55.module = newModule5
        
        let question56 = Question(context: self.coreDataContext)
        question56.questionId = 6
        question56.firebaseId = 41
        question56.question = "Why do you say that?"
        question56.answerType = "TextView"
        //question56.placeholderText = "Specify"
        question56.module = newModule5
        
        
        
        let newModule6 = Module(context: self.coreDataContext)
        newModule6.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule6.moduleName = "Module 6: Economy and Society"
        
        let question61 = Question(context: self.coreDataContext)
        question61.questionId = 1
        question61.firebaseId = 42
        question61.nextQuestionId = 2
        question61.question = "We would like to ask you about your expectations for America’s economy in the year ahead. We are going to list some indicators related to the economy. For each one we would like you to tell us whether you think during the next twelve months it will go up, go down, or stay about the same compared to now?"
        
        question61.questionItalicText = "Select one answer for each question."
        question61.answerType = "Grid"
        question61.gridQuestions = ["Unemployment",
                                    "Interest rates for borrowing money",
                                    "Prices in general",
                                    "Prices of major household items (e.g., furniture, refrigerator, stove, television)",
                                    "Prices of vehicles (e.g., car, pickup, van)",
                                    "Price of gasoline",
                                    "Availability of affordable housing",
                                    "Stock market",
                                    "Average income in the country as a whole"
                                    ]
        question61.answerChoices = [
            "Go up",
            "Stay the same",
            "Go down"
        ]        
        question61.isFirst = true
        question61.module = newModule6
        question61.moduleStartInfo = "This section focuses on economic and social issues. Please read each question carefully and provide an answer."
        
        
        
        let question62 = Question(context: self.coreDataContext)
        question62.questionId = 2
        question62.firebaseId = 43
        question62.nextQuestionId = 3
        question62.question = "Do you expect that your household income will increase by more than the rate of inflation during the next five years or so?"
        question62.answerType = "BCQ"
        question62.answerChoices = [
            "Yes",
            "No"]
        question62.module = newModule6
        
        let question63 = Question(context: self.coreDataContext)
        question63.questionId = 3
        question63.firebaseId = 44
        question63.nextQuestionId = 4
        question63.question = "Please read the following statements and indicate whether you strongly agree, agree, disagree, or strongly disagree with each statement:"
        question63.questionItalicText = "Select one answer for each question."
        question63.gridQuestions = ["A working mother can establish just as warm and secure a relationship with her children as a mother who does not work.",
                                    "A preschool child is likely to suffer if his or her mother works.",
                                    "It is much better for everyone involved if the man is the achiever outside the home and the woman takes care of the home and family.",
                                    "Family life often suffers because men concentrate too much on their work.",
                                    "Employers should make special efforts to hire and promote qualified women."]
        question63.answerType = "Grid"
        question63.answerChoices = ["Strongly agree",
                                    "Agree",
                                    "Disagree",
                                    "Strongly disagree"]
        question63.module = newModule6
        
        let question64 = Question(context: self.coreDataContext)
        question64.questionId = 4
        question64.firebaseId = 45
        question64.nextQuestionId = 5
        question64.question = "Some people say that because of past discrimination, women should be given preference in hiring and promotion. Others say that such preference in hiring and promotion of women is wrong because it discriminates against men. What about your opinion - are you for or against preferential hiring and promotion of women?"
        question64.answerType = "BCQ"
        question64.answerChoices = [
            "For",
            "Against"]
        question64.module = newModule6
        
//        let question65 = Question(context: self.coreDataContext)
//        question65.questionId = 5
//        question65.firebaseId = 46
//        question65.nextQuestionId = 6
//        question65.question = "Could you tell us why you say that?"
//        question65.answerType = "TextView"
//        question65.module = newModule6
        
        let question66 = Question(context: self.coreDataContext)
        question66.questionId = 5
        question66.firebaseId = 47
        question66.nextQuestionId = 6
        question66.question = "What do you think the chances are these days that a man won't get a job or promotion while an equally or less qualified woman gets one instead?"
        question66.answerType = "BCQ"
        question66.answerChoices = [
            "Very likely",
            "Somewhat likely",
            "Somewhat unlikely",
            "Very unlikely"
        ]
        question66.module = newModule6
        
        let question67 = Question(context: self.coreDataContext)
        question67.questionId = 6
        question67.firebaseId = 48
        question67.question = "What do you think the chances are these days that a woman won't get a job or promotion while an equally or less qualified man gets one instead?"
        question67.answerType = "BCQ"
        question67.answerChoices = [
            "Very likely",
            "Somewhat likely",
            "Somewhat unlikely",
            "Very unlikely"
        ]
        question67.module = newModule6
        
//        let question68 = Question(context: self.coreDataContext)
//        question68.questionId = 8
//        question68.firebaseId = 49
//        question68.question = "Could you tell us more about that?"
//        question68.answerType = "TextView"
//        question68.module = newModule6
        
        let newModule7 = Module(context: self.coreDataContext)
        newModule7.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule7.moduleName = "Module 7: Technology"
        
        let question71 = Question(context: self.coreDataContext)
        question71.questionId = 1
        question71.firebaseId = 50
        question71.nextQuestionId = 2
        question71.question = "During the last month, how many times did you use your iPhone to watch any streaming video?"
        question71.answerType = "Numeric"
        question71.placeholderText = "Number of times"
        question71.isFirst = true
        question71.module = newModule7
        question71.moduleStartInfo = "The next few questions are about smartphone usage."
        
        let question72 = Question(context: self.coreDataContext)
        question72.questionId = 2
        question72.firebaseId = 51
        question72.nextQuestionId = 3
        question72.question = "During the last month, how many times did you use your iPhone to make an online purchase?"
        question72.answerType = "Numeric"
        question72.placeholderText = "Number of times"
        question72.module = newModule7
        
        let question73 = Question(context: self.coreDataContext)
        question73.questionId = 3
        question73.firebaseId = 52
        question73.nextQuestionId = 4
        question73.question = "How many apps do you currently have on your iPhone, including those that came preloaded on the phone and those you downloaded yourself?"
        question73.answerType = "Numeric"
        question73.placeholderText = "Number"
        question73.module = newModule7
        
        let question74 = Question(context: self.coreDataContext)
        question74.questionId = 4
        question74.firebaseId = 53
        question74.nextQuestionId = 5
        question74.question = "During the past week, how many minutes or hours did use the apps on your iPhone?"
        question74.questionItalicText = "You can find this information on your iPhone in four steps: 1. launch the Settings app; 2. scroll down to the words \"Screen Time\" or search for \"screen time\"; 3. tap \"See All Activity\"; and 4. Tap \"Week\" at the top of the screen to see your \"Total Screen Time\" for the week. If you don't have Screen Time enabled then enter your best estimate"
        question74.answerType = "Numeric&Numeric"
        question74.placeholderText = "Hour:Minutes"
        question74.module = newModule7
        
        //Condition Wise
        let question75 = Question(context: self.coreDataContext)
        question75.questionId = 5
        question75.firebaseId = 54
        question75.nextQuestionId = 6
        question75.question = "Currently, what information sources do you usually turn to for news about current issues and events?"
        switch condition{
        case "a":
            question75.answerType = "TextView"
        case "b":
            question75.answerType = "TextView"
            question75.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question75.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question75.answerType = "Voice"
            question75.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question75.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question75.answerType = "TextAndVoice"
            question75.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question75.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
        default:
            question75.answerType = "TextView"
        }
        question75.module = newModule7
        
        let question76 = Question(context: self.coreDataContext)
        question76.questionId = 6
        question76.firebaseId = 55
        question76.nextQuestionId = 7
        question76.question = "When thinking about a job, what factors are important to you?"
        switch condition{
        case "a":
            question76.answerType = "TextView"
        case "b":
            question76.answerType = "TextView"
            question76.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question76.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question76.answerType = "Voice"
            question76.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question76.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question76.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question76.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question76.answerType = "TextAndVoice"
        default:
            question76.answerType = "TextView"
        }
        question76.placeholderText = "Specify"
        question76.module = newModule7
        
        let question77 = Question(context: self.coreDataContext)
        question77.questionId = 7
        question77.firebaseId = 56
        question77.nextQuestionId = 8
        question77.question = "In your own words, what are some lessons that humankind should learn from the coronavirus outbreak?"
        switch condition{
        case "a":
            question77.answerType = "TextView"
        case "b":
            question77.answerType = "TextView"
            question77.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question77.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question77.answerType = "Voice"
            question77.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question77.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question77.answerType = "TextAndVoice"
            question77.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question77.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            
        default:
            question77.answerType = "TextView"
        }
        question77.module = newModule7
        
        // Debreifing Question
        let question78 = Question(context: self.coreDataContext)
        question78.questionId = 8
        question78.firebaseId = 57
        question78.nextQuestionId = 9
        question78.question = "How easy or difficult was it for you to complete this study?"
        question78.answerType = "BCQ"
        question78.answerChoices = ["Very easy",
                                    "Somewhat easy",
                                    "Neither easy nor difficult",
                                    "Somewhat difficult",
                                    "Very difficult"]
        question78.module = newModule7
        question78.moduleStartInfo = "This is the final section of the study. It has questions about your experience with the study. When answering these questions, please consider all parts of the survey, from the first section to the current section."
        
        let question79 = Question(context: self.coreDataContext)
        question79.questionId = 9
        question79.firebaseId = 58
        question79.nextQuestionId = 10
        question79.question = "Why did you say that?"
        question79.answerType = "TextView"
        question79.module = newModule7
        
        
        let question710 = Question(context: self.coreDataContext)
        question710.questionId = 10
        question710.firebaseId = 59
        question710.nextQuestionId = 11
        question710.question = "How many minutes do you think that you spent on this study?"
        question710.answerType = "Numeric"
        question710.placeholderText = "Number of minutes"
        question710.module = newModule7
        
        let question711 = Question(context: self.coreDataContext)
        question711.questionId = 11
        question711.firebaseId = 60
        question711.nextQuestionId = 12
        question711.question = "Did you experience any technical difficulties with the survey? Please tell us what problems you encountered and (if applicable) how you solved them."
        question711.answerType = "TextView"
        question711.module = newModule7
        
        let question712 = Question(context: self.coreDataContext)
        question712.questionId = 12
        question712.nextQuestionId = 13
        question712.firebaseId = 61
        question712.question = "Did you do any of the following activities while completing any part of the survey? Please select all that apply."
        question712.answerType = "MCQ"
        question712.answerChoices = ["Watch TV or videos",
                                    "Listen to music",
                                    "Chat with other people (on the phone, face-to-face)",
                                    "Text with other people",
                                    "Prepare a meal, eat or drink",
                                    "Travel on foot or in a vehicle",
                                    "Idle (e.g., wait for someone, in line for an appointment)",
                                    "Other activities"]
        question712.placeholderText = "Specify"
        question712.otherOption = ["Other activities"]
        question712.module = newModule7
        
        let question713 = Question(context: self.coreDataContext)
        question713.questionId = 13
        question713.nextQuestionId = 14
        question713.firebaseId = 62
        question713.question = "Where were you when you were working on the survey? Please select all that apply."
        question713.questionItalicText = "Please consider where you were when completing all parts of the survey, from the first section to the current section."
        question713.answerType = "MCQ"
        question713.answerChoices = ["At home",
                                   "At work",
                                   "In transit",
                                   "Other location"]
        question713.otherOption = ["Other location"]
        question713.placeholderText = "Specify"
        question713.module = newModule7
        
        //Experimental Conditions
        let appVoiceCondition = "\(appCondition)\(condition)"
        
        if (appCondition == "1") {
            let question714 = Question(context: self.coreDataContext)
            question714.questionId = 14
            question714.nextQuestionId = 15
            question714.firebaseId = 63
            question714.question = "How would you rate the amount of time it took to complete each module?"
            question714.answerType = "BCQ"
            question714.answerChoices = ["They were too long",
                                       "They were about right",
                                       "They were too short"
                                        ]
            question714.module = newModule7
            
            let question715 = Question(context: self.coreDataContext)
            question715.questionId = 15
            question715.nextQuestionId = 16
            question715.firebaseId = 65
            question715.question = "For this study, we’ve been sending you a new module every other day. How often would you prefer us sending you a new module?"
            question715.answerType = "BCQ"
            question715.answerChoices = ["One module per day",
                                       "One module every other day (the current setup)",
                                       "One module per week",
                                       "One module every other week",
                                       "One module per month",
                                       "Just send all modules at once",
                                       "Some other frequencies",
                                        ]
            question715.otherOption = ["Some other frequencies"]
            question715.placeholderText = "Specify"
            question715.module = newModule7
            
            let question716 = Question(context: self.coreDataContext)
            question716.questionId = 16
            question716.nextQuestionId = 17
            question716.firebaseId = 66
            question716.question = "If you were to complete another survey using this app, would you prefer the current format (having different modules pushed to your app regularly) or having all modules available on day 1?"
            question716.answerType = "BCQ"
            question716.answerChoices = ["Having different modules pushed to my app regularly",
                                       "Having all modules available on day 1",
                                       "I don’t have a preference"
                                        ]
            question716.placeholderText = "Specify"
            question716.module = newModule7
            
            if (condition == "b" || condition == "c" || condition == "d" ) {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 17
                question717.nextQuestionId = 18
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule7
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 18
                //question718.nextQuestionId = 19
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "BCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.otherOption = ["Other reason"]
                question718.placeholderText = "Specify"
                question718.module = newModule7
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 18
                //question716.nextQuestionId = 16
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule7
            }
        }
        
        if (appCondition == "2") {
            let question714 = Question(context: self.coreDataContext)
            question714.questionId = 14
            question714.nextQuestionId = 15
            question714.firebaseId = 63
            question714.question = "How would you rate the amount of time it took to complete each module?"
            question714.answerType = "BCQ"
            question714.answerChoices = ["They were too long",
                                       "They were about right",
                                       "They were too short"
                                        ]
            question714.module = newModule7
            
            let question715 = Question(context: self.coreDataContext)
            question715.questionId = 15
            question715.nextQuestionId = 16
            question715.firebaseId = 64
            question715.question = "If you were to complete another survey using this app, would you prefer the current format (having all modules available on day 1) or having different modules pushed to your app regularly (e.g., every other day)?"
            question715.answerType = "BCQ"
            question715.answerChoices = ["Having all modules available on day 1",
                                       "Having different modules pushed to my app regularly",
                                       "I don’t have a preference"
                                        ]
            question715.module = newModule7
            
            if (condition == "b" || condition == "c" || condition == "d" ) {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 16
                question717.nextQuestionId = 17
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule7
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 17
                //question718.nextQuestionId = 18
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "BCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.placeholderText = "Specify"
                question718.otherOption = ["Other reason"]
                question718.module = newModule7
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 17
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule7
            }
        }
        
        if (appCondition == "3") {
            if (condition == "b" || condition == "c" || condition == "d" ) {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 14
                question717.nextQuestionId = 15
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule7
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 15
                //question718.nextQuestionId = 16
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "MCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.placeholderText = "Specify"
                question718.otherOption = ["Other reason"]
                question718.module = newModule7
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 15
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule7
            }
        }
        
        do {
            try coreDataContext.save()
            getModulesFromCoreDate()
        }
        catch {
            print("Error Saving Data")
        }
        
    }
    
    func createCoreDataWithNotifyModules(){
        
        /*
        let newModule1 = Module(context: self.coreDataContext)
        newModule1.dateAdded = Calendar.current.date(byAdding: .minute, value: -3, to: Date())
        newModule1.moduleName = "Principal Employer"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.nextQuestionId = 2
        question1.question = "During the week of April 25, 2022, who was your principal employer?"
        question1.questionItalicText = "If you had more than one job, report the one for which you worked the most hours that week.\nIf you worked for a contracting or consulting company, report the name of that company, not the client organization."
        question1.placeholderText = "Employer Name"
        question1.answerType = "Text"
        question1.isFirst = true
        question1.module = newModule1
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.nextQuestionId = 3
        question2.question = "Which one of the following best describes your principal employer during the week of April 25, 2022?"
        question2.answerType = "BCQ"
        question2.answerChoices = [
            "in a non-incorporated business, professional practice, or farm",
            "in an incorporated business, professional practice, or farm",
            "in a for-profit company or organization",
            "in a non-profit organization (including private colleges/universities)",
            "in a local government (e.g., city, county, school district)",
            "in a state government (including state colleges/universities)",
            "in the U.S. military service, active duty or Commissioned Corps (e.g., USPHS, NOAA)",
            "in the U.S. Federal government (e.g., civilian employee)",
            "Another type of employee, Specify"]
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.nextQuestionId = 4
        question3.question = "What was that employer’s main business or industry – that is, what did that employer make or do?"
        question3.questionItalicText = "If your principal employer had more than one type of business, report the type of business primarily performed at the location where you worked.\nExample: Production of microprocessor chips"
        question3.placeholderText = "EMPLOYER’S MAIN BUSINESS"
        question3.answerType = "Text"
        question3.module = newModule1
        
        let question4 = Question(context: self.coreDataContext)
        question4.questionId = 4
        question4.nextQuestionId = 5
        question4.question = "Counting all locations where this employer operates, how many people work for your principal employer? Your best estimate is fine."
        question4.answerType = "BCQ"
        question4.answerChoices = ["10 or fewer employees",
                                    "11 – 24 employees",
                                    "25 – 99 employees",
                                    "100 – 499 employees",
                                    "500 – 999 employees",
                                    "1,000 – 4,999 employees",
                                    "5,000 – 24,999 employees",
                                    "25,000 or more employees"]
        question4.module = newModule1
        
        let question5 = Question(context: self.coreDataContext)
        question5.questionId = 5
        question5.nextQuestionId = 6
        question5.question = "Was your principal employer established as a new business within the past 5 years?"
        question5.answerType = "BCQ"
        question5.answerChoices = ["Yes",
                                    "No"]
        question5.module = newModule1
        
        let question6 = Question(context: self.coreDataContext)
        question6.questionId = 6
        question6.question = "Was your principal employer an educational institution?"
        question6.answerType = "BCQ"
        question6.answerChoices = ["Yes",
                                    "No"]
        question6.module = newModule1
        
        
        
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
 */
        
        let condition = UserDefaults.standard.string(forKey: "VoiceCondition")
        let appCondition = UserDefaults.standard.string(forKey: "AppCondition")
        let newModule1 = Module(context: self.coreDataContext)
        let date = Calendar.current.date(byAdding: .minute, value: -1, to: Date())
        newModule1.dateAdded = date
        newModule1.moduleName = "Module 1: Employer"
        
        let question1 = Question(context: self.coreDataContext)
        question1.questionId = 1
        question1.firebaseId = 1
        question1.nextQuestionId = 2
        question1.question = "During the week of April 25, 2022, who was your principal employer?"
        question1.questionItalicText = "If you had more than one job, report the one for which you worked the most hours that week.\nIf you worked for a contracting or consulting company, report the name of that company, not the client organization."
        question1.placeholderText = "Employer Name"
        question1.answerType = "Text"
        question1.isFirst = true
        question1.module = newModule1
        question1.moduleStartInfo = "The questions in this section are about your principal employer. Please read each question carefully and provide an answer."
        
        let question2 = Question(context: self.coreDataContext)
        question2.questionId = 2
        question2.firebaseId = 2
        question2.nextQuestionId = 3
        question2.question = "Which one of the following best describes your principal employer during the week of April 25, 2022?"
        question2.answerType = "BCQ"
        question2.answerChoices = [
            "SELF EMPLOYED OR A BUSINESS OWNER in a non-incorporated business, professional practice, or farm",
            "SELF EMPLOYED OR A BUSINESS OWNER in an incorporated business, professional practice, or farm",
            "PRIVATE SECTOR employee in a for-profit company or organization",
            "PRIVATE SECTOR employee in a non-profit organization (including private colleges/universities)",
            "GOVERNMENT employee in a local government (e.g., city, county, school district)",
            "GOVERNMENT employee in a state government (including state colleges/universities)",
            "GOVERNMENT employee in the U.S. military service, active duty or Commissioned Corps (e.g., USPHS, NOAA)",
            "GOVERNMENT employee in the U.S. Federal government (e.g., civilian employee)",
            "Another type of employee"]
        question2.otherOption = ["Another type of employee"]
        question2.placeholderText = "Specify"
        question2.module = newModule1
        
        let question3 = Question(context: self.coreDataContext)
        question3.questionId = 3
        question3.firebaseId = 3
        question3.nextQuestionId = 4
        question3.question = "What was that employer’s main business or industry – that is, what did that employer make or do?"
        question3.questionItalicText = "If your principal employer had more than one type of business, report the type of business primarily performed at the location where you worked.\nExample: Production of microprocessor chips"
        question3.placeholderText = "EMPLOYER’S MAIN BUSINESS"
        question3.answerType = "Text"
        question3.module = newModule1
        
        let question4 = Question(context: self.coreDataContext)
        question4.questionId = 4
        question4.firebaseId = 4
        question4.nextQuestionId = 5
        question4.question = "Counting all locations where this employer operates, how many people work for your principal employer? Your best estimate is fine."
        question4.answerType = "BCQ"
        question4.answerChoices = ["10 or fewer employees",
                                    "11 – 24 employees",
                                    "25 – 99 employees",
                                    "100 – 499 employees",
                                    "500 – 999 employees",
                                    "1,000 – 4,999 employees",
                                    "5,000 – 24,999 employees",
                                    "25,000 or more employees"]
        question4.module = newModule1
        
        let question5 = Question(context: self.coreDataContext)
        question5.questionId = 5
        question5.firebaseId = 5
        question5.nextQuestionId = 6
        question5.question = "Was your principal employer established as a new business within the past 5 years?"
        question5.answerType = "BCQ"
        question5.answerChoices = ["Yes",
                                    "No"]
        question5.module = newModule1
        
        let question6 = Question(context: self.coreDataContext)
        question6.questionId = 6
        question6.firebaseId = 6
        question6.question = "Was your principal employer an educational institution?"
        question6.answerType = "BCQ"
        question6.answerChoices = ["Yes",
                                    "No"]
        question6.module = newModule1
        
        
        let newModule2 = Module(context: self.coreDataContext)
        //let date2 = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        let date2 = Calendar.current.date(byAdding: .minute, value: 2, to: Date())
        newModule2.dateAdded = date2
        newModule2.moduleName = "Module 2: Job Duties"
        createLocalNotification(title: "New Module Published", body: "Module 2 has been released", date: date2!)
        
        let question21 = Question(context: self.coreDataContext)
        question21.questionId = 1
        question21.firebaseId = 7
        question21.nextQuestionId = 2
        question21.question = "During the week of April 25, 2022, what was the title of the principal job you held?"
        question21.questionItalicText = "Example: Financial Analyst"
        question21.answerType = "Text"
        question21.isFirst = true
        question21.module = newModule2
        question21.moduleStartInfo = "This section has questions about your job duties and salary. Please read each question carefully and provide an answer."
        
        let question22 = Question(context: self.coreDataContext)
        question22.questionId = 2
        question22.firebaseId = 8
        question22.nextQuestionId = 3
        question22.question = "What kind of work were you doing on this job – that is, what were your duties and responsibilities on your principal job? Please be as specific as possible, including any area of specialization."
        question22.questionItalicText = "Examples: Analyzed financial information, prepared technical reports, specialized in asset management."
        question22.answerType = "TextView"
        question22.module = newModule2
        
        let question23 = Question(context: self.coreDataContext)
        question23.questionId = 3
        question23.firebaseId = 9
        question23.nextQuestionId = 4
        question23.question = "Did your duties on this job require the technical expertise of a bachelor’s degree or higher in engineering, computer science, math, or the natural sciences?"
        question23.answerType = "BCQ"
        question23.answerChoices = ["Yes",
                                    "No"]
        question23.module = newModule2
        
        let question24 = Question(context: self.coreDataContext)
        question24.questionId = 4
        question24.firebaseId = 10
        question24.nextQuestionId = 5
        question24.question = "Did your duties on this job require the technical expertise of a bachelor’s degree or higher in the social sciences?"
        question24.answerType = "BCQ"
        question24.answerChoices = ["Yes",
                                    "No"]
        question24.module = newModule2
        
        let question25 = Question(context: self.coreDataContext)
        question25.questionId = 5
        question25.firebaseId = 11
        question25.nextQuestionId = 6
        question25.question = "During what month and year did you start this job (that is, the principal job you held during the week of April 25, 2022)?"
        //question25.questionItalicText = "Principal job started??? Date Time??"
        question25.answerType = "Date"
        question25.placeholderText = "Principal job started"
        question25.module = newModule2
        
        let question26 = Question(context: self.coreDataContext)
        question26.questionId = 6
        question26.firebaseId = 12
        question26.nextQuestionId = 7
        question26.question = "The next question is about your work activities on your principal job. Which of the following work activities occupied at least 10 percent of your time during a typical work week on this job?"
        question26.questionItalicText = "Check all that apply"
        question26.answerType = "MCQ"
        question26.answerChoices = ["Accounting, finance, contracts",
                                    "Basic research – study directed toward gaining scientific knowledge primarily for its own sake",
                                    "Applied research – study directed toward gaining scientific knowledge to meet a recognized need",
                                    "Development – using knowledge gained from research for the production of materials, devices",
                                    "Design of equipment, processes, structures, models",
                                    "Computer programming, systems, or applications development",
                                    "Human resources – including recruiting, personnel development, training",
                                    "Managing or supervising people or projects",
                                    "Production, operations, maintenance (e.g., chip production, operating lab equipment)",
                                    "Professional services (e.g., health care, counseling, financial services, legal services)",
                                    "Sales, purchasing, marketing, customer service, public relations",
                                    "Quality or productivity management",
                                    "Teaching",
                                    "Other activity"]
        question26.otherOption = ["Other activity"]
        question26.placeholderText = "Specify"
        
        question26.module = newModule2
        
        let question27 = Question(context: self.coreDataContext)
        question27.questionId = 7
        question27.firebaseId = 13
        question27.nextQuestionId = 8
        question27.question = "On which activity did you work the most hours during a typical week on this job?"
        question27.questionItalicText = "Select the activity in which you worked the most hours from the list."
        question27.answerType = "BCQ"
        question27.answerChoices = ["Accounting, finance, contracts",
                                    "Basic research – study directed toward gaining scientific knowledge primarily for its own sake",
                                    "Applied research – study directed toward gaining scientific knowledge to meet a recognized need",
                                    "Development – using knowledge gained from research for the production of materials, devices",
                                    "Design of equipment, processes, structures, models",
                                    "Computer programming, systems, or applications development",
                                    "Human resources – including recruiting, personnel development, training",
                                    "Managing or supervising people or projects",
                                    "Production, operations, maintenance (e.g., chip production, operating lab equipment)",
                                    "Professional services (e.g., health care, counseling, financial services, legal services)",
                                    "Sales, purchasing, marketing, customer service, public relations",
                                    "Quality or productivity management",
                                    "Teaching",
                                    "Other activity"]
        question27.otherOption = ["Other activity"]
        question27.placeholderText = "Specify"
        question27.module = newModule2
        
        
        let question28 = Question(context: self.coreDataContext)
        question28.questionId = 8
        question28.firebaseId = 14
        question28.nextQuestionId = 9
        question28.question = "As part of the principal job you held during the week of April 25, 2022, did you supervise the work of others?"
        question28.questionItalicText = "Mark “Yes” if you recommended or initiated personnel actions such as hiring, firing, evaluating, or promoting others.\nTeachers: Do not count students."
        question28.answerType = "BCQ"
        question28.answerChoices = ["Yes",
                                    "No"]
        question28.module = newModule2
        
        let question29 = Question(context: self.coreDataContext)
        question29.questionId = 9
        question29.firebaseId = 15
        question29.nextQuestionId = 10
        question29.question = "During a typical week on your principal job, how many hours did you work?"
        question29.answerType = "Numeric"
        question29.placeholderText = "Number of hours worked per week"
        question29.module = newModule2
        
        let question210 = Question(context: self.coreDataContext)
        question210.questionId = 10
        question210.firebaseId = 16
        question210.nextQuestionId = 11
        question210.question = "As of the week of April 25, 2022, what was your basic annual salary on your principal job, before deductions?"
        question210.questionItalicText = "Do not include bonuses, overtime, or additional compensation for summertime teaching or research. If you are not salaried, please estimate your earned income, excluding business expenses."
        question210.answerType = "Numeric"
        question210.placeholderText = "$"
        question210.module = newModule2
        
        let question211 = Question(context: self.coreDataContext)
        question211.questionId = 11
        question211.firebaseId = 17
        question211.nextQuestionId = 12
        question211.question = "Was this salary based on a 52-week year, or less than that?"
        question211.questionItalicText = "Include paid vacation and sick leave."
        question211.answerType = "BCQ"
        question211.answerChoices = ["52-week year",
                                    "Less than 52 weeks"]
        question211.placeholderText = "Number of weeks per year"
        question211.otherOption = ["Less than 52 weeks"]
        question211.module = newModule2
        
        let question212 = Question(context: self.coreDataContext)
        question212.questionId = 12
        question212.firebaseId = 18
        question212.question = "Please indicate how much you agree or disagree with the following statements about balancing your professional and personal responsibilities in your current position."
        question212.questionItalicText = "Select one answer for each question."
        question212.gridQuestions = ["Your current position is stressful.",
                                     "You can manage the demands of your position.",
                                     "Your work schedule allows you to maintain your overall quality of life.",
                                     "Your supervisor understands when demands at home interfere with your professional responsibilities",
                                     "Demands at home have slowed down progress on your professional activities."]
        question212.answerType = "Grid"
        question212.answerChoices = ["Strongly agree",
                                    "Somewhat agree",
                                    "Somewhat disagree",
                                    "Strongly disagree"]
        
        question212.placeholderText = "Number of weeks per year"
        question212.module = newModule2
        
        let newModule3 = Module(context: self.coreDataContext)
        //let date3 = Calendar.current.date(byAdding: .day, value: 4, to: Date())
        let date3 = Calendar.current.date(byAdding: .minute, value: 4, to: Date())
        newModule3.dateAdded = date3
        newModule3.moduleName = "Module 3: Job Satisfaction"
        createLocalNotification(title: "New Module Published", body: "Module 3 has been released", date: date3!)
        
        
        let question31 = Question(context: self.coreDataContext)
        question31.questionId = 1
        question31.firebaseId = 19
        question31.nextQuestionId = 2
        question31.question = "Thinking about the principal job you held during the week of April 25, 2022, how would you rate your overall satisfaction?"
        question31.answerType = "BCQ"
        question31.answerChoices = [
            "Very satisfied",
            "Somewhat satisfied",
            "Somewhat dissatisfied",
            "Very dissatisfied"
        ]
        question31.isFirst = true
        question31.module = newModule3
        question31.moduleStartInfo = "The questions in this section are about your job satisfaction and how the pandemic has affected your work."
        
        
        
        let question32 = Question(context: self.coreDataContext)
        question32.questionId = 2
        question32.firebaseId = 20
        question32.nextQuestionId = 3
        question32.question = "Thinking about the principal job you held during the week of April 25, 2022, how satisfied or dissatisfied were you with the following aspects of the job?"
        question32.gridQuestions = ["Salary",
                                    "Benefits",
                                    "Job security",
                                    "Job location",
                                    "Opportunities for advancement",
                                    "Intellectual challenge",
                                    "Level of responsibility",
                                    "Degree of independence",
                                    "Contribution to society"]
        question32.questionItalicText = "Select one answer for each question."
        question32.answerType = "Grid"
        question32.answerChoices = [
            "Very satisfied",
            "Somewhat satisfied",
            "Somewhat dissatisfied",
            "Very dissatisfied"
            ]
        question32.module = newModule3
        
        let question33 = Question(context: self.coreDataContext)
        question33.questionId = 3
        question33.firebaseId = 21
        question33.nextQuestionId = 4
        question33.question = "For the principal job you held during the week of April 25, 2022, has your basic annual salary been affected at any time by the coronavirus pandemic?"
        question33.answerType = "BCQ"
        question33.answerChoices = ["Yes",
                                    "No"]
        question33.module = newModule3
        
        let question34 = Question(context: self.coreDataContext)
        question34.questionId = 4
        question34.firebaseId = 22
        question34.nextQuestionId = 5
        question34.question = "In general, how has your work been affected as a result of the coronavirus pandemic?"
        question34.answerType = "TextView"
        //question34.placeholderText = "Define"
        question34.module = newModule3
        
        let question35 = Question(context: self.coreDataContext)
        question35.questionId = 5
        question35.firebaseId = 23
        question35.question = "In general, how have your career plans been affected as a result of the coronavirus pandemic?"
        question35.answerType = "TextView"
        //question35.placeholderText = "Define"
        question35.module = newModule3
        
        
        let newModule4 = Module(context: self.coreDataContext)
        //let date4 = Calendar.current.date(byAdding: .day, value: 6, to: Date())
        let date4 = Calendar.current.date(byAdding: .minute, value: 6, to: Date())
        newModule4.dateAdded = date4
        newModule4.moduleName = "Module 4: Job Benefits"
        createLocalNotification(title: "New Module Published", body: "Module 4 has been released", date: date4!)
        
        let question41 = Question(context: self.coreDataContext)
        question41.questionId = 1
        question41.firebaseId = 24
        question41.nextQuestionId = 2
        question41.question = "Thinking of your principal job during the week of April 25, 2022, which of the following benefits were available to you, even if you chose not to take them?"
        question41.questionItalicText = "Check all that apply"
        question41.answerType = "MCQ"
        question41.answerChoices = ["Health insurance that was at least partially paid by your employer",
                                    
                                    "BA pension plan or a retirement plan to which your employer contributed",
                                    "A profit-sharing plan",
                                    "New or additional paid leave due to the coronavirus pandemic",
                                    "Paid vacation, sick or personal days unrelated to the coronavirus pandemic"]
        question41.isFirst = true
        question41.module = newModule4
        question41.moduleStartInfo = "This section focuses on your job benefits and security. Please read each question carefully and provide an answer. "
        
        let question42 = Question(context: self.coreDataContext)
        question42.questionId = 2
        question42.firebaseId = 25
        question42.nextQuestionId = 3
        question42.question = "Thinking of your principal job during the week of April 25, 2022, which of the following best describes whether you were allowed or required to telecommute/work remotely?"
        question42.answerType = "BCQ"
        question42.answerChoices = ["I was allowed or required to telecommute/work remotely due to the coronavirus pandemic",
                                    "I was allowed or required to telecommute/work remotely regardless of the coronavirus pandemic",
                                    "I was not allowed or required to telecommute/work remotely",
                                    "Telecommuting/working remotely did not make sense for my job"]
        question42.module = newModule4
        
        let question43 = Question(context: self.coreDataContext)
        question43.questionId = 3
        question43.firebaseId = 26
        question43.nextQuestionId = 4
        question43.question = "Thinking back now to 2021 was any of your work during 2021 supported by contracts or grants from the U.S. Federal Government?"
        question43.questionItalicText = "Federal employees: Please answer “No.“"
        question43.answerType = "BCQ"
        question43.answerChoices = ["Did not work in 2020",
                                    "Yes",
                                    "No",
                                    "Don’t know"]
        question43.module = newModule4
        
        let question44 = Question(context: self.coreDataContext)
        question44.questionId = 4
        question44.firebaseId = 27
        question44.nextQuestionId = 5
        question44.question = "Please indicate how much you agree or disagree with the following statements about your current position."
        question44.questionItalicText = "Select one answer for each question."
        question44.gridQuestions = ["I have a mentor who I can rely on for career advice.",
                                    "I am given a high degree of independence.",
                                    "I have an opportunity to take work-related trainings, such as workshops or seminars.",
                                    "I am paid fairly for the work I do.",
                                    "I have opportunities for promotion or advancement in your current occupation."]

        question44.answerType = "Grid"
        question44.answerChoices = ["Strongly agree",
                                    "Somewhat agree",
                                    "Somewhat disagree",
                                    "Strongly disagree"]
        question44.module = newModule4
        
        let question45 = Question(context: self.coreDataContext)
        question45.questionId = 5
        question45.firebaseId = 28
        question45.nextQuestionId = 6
        question45.question = "Thinking about the next 12 months, how likely do you think it is that you will lose your job or be laid off?"
        question45.answerType = "BCQ"
        question45.answerChoices = ["Very likely",
                                    "Fairly likely",
                                    "Not too likely",
                                    "Not at all likely"]
        question45.module = newModule4
        
//        let question46 = Question(context: self.coreDataContext)
//        question46.questionId = 6
//        question46.firebaseId = 29
//        question46.nextQuestionId = 7
//        question46.question = "Could you tell us why you say that?"
//        question46.answerType = "TextView"
//        //question46.placeholderText = "Specify"
//        question46.module = newModule4
        
        let question47 = Question(context: self.coreDataContext)
        question47.questionId = 6
        question47.firebaseId = 30
        question47.nextQuestionId = 7
        question47.question = "About how easy would it be for you to find a job with another employer with approximately the same income and fringe benefits you now have?"
        question47.answerType = "BCQ"
        question47.answerChoices = ["Very likely",
                                    "Fairly likely",
                                    "Not too likely",
                                    "Not at all likely"]
        question47.module = newModule4
        
        
//        let question48 = Question(context: self.coreDataContext)
//        question48.questionId = 8
//        question48.firebaseId = 31
//        question48.nextQuestionId = 9
//        question48.question = "Could you tell us why you say that?"
//        question48.answerType = "TextView"
//        //question48.placeholderText = "Specify"
//        question48.module = newModule4
        
        let question49 = Question(context: self.coreDataContext)
        question49.questionId = 7
        question49.firebaseId = 32
        question49.nextQuestionId = 8
        question49.question = "As of April 25, 2022, did you have any active professional certifications or state or industry licenses?"
        question49.questionItalicText = "A professional certification or license shows you are qualified to perform a specific job. Only include certifications or licenses obtained by an individual. Examples include Certified Teacher, Registered Nurse, Licensed Professional Engineer, a Project Management certification, or an IT certification.\nDo not include licenses needed by a business to operate."
        question49.answerType = "BCQ"
        question49.answerChoices = ["Yes",
                                    "No"]
        question49.module = newModule4
        
        let question410 = Question(context: self.coreDataContext)
        question410.questionId = 8
        question410.firebaseId = 33
        question410.nextQuestionId = 9
        question410.question = "During the past 12 months, did you take any work-related training, such as workshops or seminars?"
        question410.questionItalicText = "Include conferences or professional meetings only if you attended a training session at the conference or meeting.\nDo not include college coursework for which you were enrolled in a degree program."
        question410.answerType = "BCQ"
        question410.answerChoices = ["Yes",
                                    "No"]
        question410.module = newModule4
        
        let question411 = Question(context: self.coreDataContext)
        question411.questionId = 9
        question411.firebaseId = 34
        question411.nextQuestionId = 10
        question411.question = "During the past 12 months, did you attend any professional conferences or professional society or association meetings?"
        question411.questionItalicText = "Include regional, national, or international meetings."
        question411.answerType = "BCQ"
        question411.answerChoices = ["Yes. I attended in person or virtually (i.e., online or by remote access)",
                                    "No"]
        question411.module = newModule4
        
        let question412 = Question(context: self.coreDataContext)
        question412.questionId = 10
        question412.firebaseId = 35
        question412.question = "To how many regional, national, or international professional societies or associations do you currently belong?"
        question412.answerType = "Numeric"
        question412.questionItalicText = "If none, enter “0.”"
        question412.placeholderText = "Number"
        question412.module = newModule4
        
        
        let newModule5 = Module(context: self.coreDataContext)
        //let date5 = Calendar.current.date(byAdding: .day, value: 8, to: Date())
        let date5 = Calendar.current.date(byAdding: .minute, value: 8, to: Date())
        newModule5.dateAdded = date5
        newModule5.moduleName = "Module 5: Job Expectations"
        createLocalNotification(title: "New Module Published", body: "Module 5 has been released", date: date5!)
        
        
        let question51 = Question(context: self.coreDataContext)
        question51.questionId = 1
        question51.firebaseId = 36
        question51.nextQuestionId = 2
        question51.question = "When thinking about a job, how important is each of the following factors to you?"
        question51.questionItalicText = "Select one answer for each question."
        question51.gridQuestions = ["Salary",
                                    "Benefits",
                                    "Job security",
                                    "Job location",
                                    "Opportunities for advancement",
                                    "Intellectual challenge",
                                    "Level of responsibility",
                                    "Degree of independence",
                                    "Contribution to society"]
        question51.answerType = "Grid"
        question51.answerChoices = [
            "Very important",
            "Somewhat important",
            "Somewhat unimportant",
            "Very unimportant"
        ]
        question51.isFirst = true
        question51.module = newModule5
        question51.moduleStartInfo = "The questions in this section about your job expectations and financial situation."
        
        
        
        let question52 = Question(context: self.coreDataContext)
        question52.questionId = 2
        question52.firebaseId = 37
        question52.nextQuestionId = 3
        question52.question = "We are interested in how people are getting along financially these days. So far as you and your family are concerned, would you say that you are pretty well satisfied with your present financial situation, more or less satisfied, or not satisfied at all?"
        question52.answerType = "BCQ"
        question52.answerChoices = [
            "Pretty well satisfied",
            "More or less satisfied",
            "Not satisfied at all"]
        question52.module = newModule5
        
        let question53 = Question(context: self.coreDataContext)
        question53.questionId = 3
        question53.firebaseId = 38
        question53.nextQuestionId = 4
        question53.question = "Could you tell us a little more about that?"
        question53.answerType = "TextView"
        //question53.placeholderText = "Specify"
        question53.module = newModule5
        
        let question54 = Question(context: self.coreDataContext)
        question54.questionId = 4
        question54.firebaseId = 39
        question54.nextQuestionId = 5
        question54.question = "Compared with American families in general, would you say your family income is--far below average, below average, average, above average, or far above average? If you are uncertain, just give us your best guess."
        question54.answerType = "BCQ"
        question54.answerChoices = [
            "Far below average",
            "Below average",
            "Average",
            "Above average",
            "Far above average"]
        question54.module = newModule5
        
        let question55 = Question(context: self.coreDataContext)
        question55.questionId = 5
        question55.firebaseId = 40
        question55.nextQuestionId = 6
        question55.question = "Some people say that people get ahead by their own hard work; others say that lucky breaks or help from other people are more important. Which do you think is most important?"
        question55.answerType = "BCQ"
        question55.answerChoices = [
            "Hard work most important",
            "Hard work, luck equally important",
            "Luck or help from other people most important"
        ]
        question55.module = newModule5
        
        let question56 = Question(context: self.coreDataContext)
        question56.questionId = 6
        question56.firebaseId = 41
        question56.question = "Why do you say that?"
        question56.answerType = "TextView"
        //question56.placeholderText = "Specify"
        question56.module = newModule5
        
        
        
        let newModule6 = Module(context: self.coreDataContext)
        //let date6 = Calendar.current.date(byAdding: .day, value: 10, to: Date())
        let date6 = Calendar.current.date(byAdding: .minute, value: 10, to: Date())
        newModule6.dateAdded = date6
        newModule6.moduleName = "Module 6: Economy and Society"
        createLocalNotification(title: "New Module Published", body: "Module 6 has been released", date: date6!)
        
        let question61 = Question(context: self.coreDataContext)
        question61.questionId = 1
        question61.firebaseId = 42
        question61.nextQuestionId = 2
        question61.question = "We would like to ask you about your expectations for America’s economy in the year ahead. We are going to list some indicators related to the economy. For each one we would like you to tell us whether you think during the next twelve months it will go up, go down, or stay about the same compared to now?"
        
        question61.questionItalicText = "Select one answer for each question."
        question61.answerType = "Grid"
        question61.gridQuestions = ["Unemployment",
                                    "Interest rates for borrowing money",
                                    "Prices in general",
                                    "Prices of major household items (e.g., furniture, refrigerator, stove, television)",
                                    "Prices of vehicles (e.g., car, pickup, van)",
                                    "Price of gasoline",
                                    "Availability of affordable housing",
                                    "Stock market",
                                    "Average income in the country as a whole"
                                    ]
        question61.answerChoices = [
            "Go up",
            "Stay the same",
            "Go down"
        ]
        question61.isFirst = true
        question61.module = newModule6
        question61.moduleStartInfo = "This section focuses on economic and social issues. Please read each question carefully and provide an answer."
        
        
        
        let question62 = Question(context: self.coreDataContext)
        question62.questionId = 2
        question62.firebaseId = 43
        question62.nextQuestionId = 3
        question62.question = "Do you expect that your household income will increase by more than the rate of inflation during the next five years or so?"
        question62.answerType = "BCQ"
        question62.answerChoices = [
            "Yes",
            "No"]
        question62.module = newModule6
        
        let question63 = Question(context: self.coreDataContext)
        question63.questionId = 3
        question63.firebaseId = 44
        question63.nextQuestionId = 4
        question63.question = "Please read the following statements and indicate whether you strongly agree, agree, disagree, or strongly disagree with each statement:"
        question63.questionItalicText = "Select one answer for each question."
        question63.gridQuestions = ["A working mother can establish just as warm and secure a relationship with her children as a mother who does not work.",
                                    "A preschool child is likely to suffer if his or her mother works.",
                                    "It is much better for everyone involved if the man is the achiever outside the home and the woman takes care of the home and family.",
                                    "Family life often suffers because men concentrate too much on their work.",
                                    "Employers should make special efforts to hire and promote qualified women."]
        question63.answerType = "Grid"
        question63.answerChoices = ["Strongly agree",
                                    "Agree",
                                    "Disagree",
                                    "Strongly disagree"]
        question63.module = newModule6
        
        let question64 = Question(context: self.coreDataContext)
        question64.questionId = 4
        question64.firebaseId = 45
        question64.nextQuestionId = 5
        question64.question = "Some people say that because of past discrimination, women should be given preference in hiring and promotion. Others say that such preference in hiring and promotion of women is wrong because it discriminates against men. What about your opinion - are you for or against preferential hiring and promotion of women?"
        question64.answerType = "BCQ"
        question64.answerChoices = [
            "For",
            "Against"]
        question64.module = newModule6
        
//        let question65 = Question(context: self.coreDataContext)
//        question65.questionId = 5
//        question65.firebaseId = 46
//        question65.nextQuestionId = 6
//        question65.question = "Could you tell us why you say that?"
//        question65.answerType = "TextView"
//        question65.module = newModule6
        
        let question66 = Question(context: self.coreDataContext)
        question66.questionId = 5
        question66.firebaseId = 47
        question66.nextQuestionId = 6
        question66.question = "What do you think the chances are these days that a man won't get a job or promotion while an equally or less qualified woman gets one instead?"
        question66.answerType = "BCQ"
        question66.answerChoices = [
            "Very likely",
            "Somewhat likely",
            "Somewhat unlikely",
            "Very unlikely"
        ]
        question66.module = newModule6
        
        let question67 = Question(context: self.coreDataContext)
        question67.questionId = 6
        question67.firebaseId = 48
        question67.question = "What do you think the chances are these days that a woman won't get a job or promotion while an equally or less qualified man gets one instead?"
        question67.answerType = "BCQ"
        question67.answerChoices = [
            "Very likely",
            "Somewhat likely",
            "Somewhat unlikely",
            "Very unlikely"
        ]
        question67.module = newModule6
        
//        let question68 = Question(context: self.coreDataContext)
//        question68.questionId = 8
//        question68.firebaseId = 49
//        question68.question = "Could you tell us more about that?"
//        question68.answerType = "TextView"
//        question68.module = newModule6
        
        let newModule7 = Module(context: self.coreDataContext)
        //let date7 = Calendar.current.date(byAdding: .day, value: 12, to: Date())
        let date7 = Calendar.current.date(byAdding: .minute, value: 12, to: Date())
        newModule7.dateAdded = date7
        newModule7.moduleName = "Module 7: Technology"
        
        createLocalNotification(title: "New Module Published", body: "Module 7 has been released", date: date7!)
        
        let question71 = Question(context: self.coreDataContext)
        question71.questionId = 1
        question71.firebaseId = 50
        question71.nextQuestionId = 2
        question71.question = "During the last month, how many times did you use your iPhone to watch any streaming video?"
        question71.answerType = "Numeric"
        question71.placeholderText = "Number of times"
        question71.isFirst = true
        question71.module = newModule7
        question71.moduleStartInfo = "The next few questions are about smartphone usage."
        
        let question72 = Question(context: self.coreDataContext)
        question72.questionId = 2
        question72.firebaseId = 51
        question72.nextQuestionId = 3
        question72.question = "During the last month, how many times did you use your iPhone to make an online purchase?"
        question72.answerType = "Numeric"
        question72.placeholderText = "Number of times"
        question72.module = newModule7
        
        let question73 = Question(context: self.coreDataContext)
        question73.questionId = 3
        question73.firebaseId = 52
        question73.nextQuestionId = 4
        question73.question = "How many apps do you currently have on your iPhone, including those that came preloaded on the phone and those you downloaded yourself?"
        question73.answerType = "Numeric"
        question73.placeholderText = "Number"
        question73.module = newModule7
        
        let question74 = Question(context: self.coreDataContext)
        question74.questionId = 4
        question74.firebaseId = 53
        question74.nextQuestionId = 5
        question74.question = "During the past week, how many minutes or hours did use the apps on your iPhone?"
        question74.questionItalicText = "You can find this information on your iPhone in four steps: 1. launch the Settings app; 2. scroll down to the words \"Screen Time\" or search for \"screen time\"; 3. tap \"See All Activity\"; and 4. Tap \"Week\" at the top of the screen to see your \"Total Screen Time\" for the week. If you don't have Screen Time enabled then enter your best estimate"
        question74.answerType = "Numeric&Numeric"
        question74.placeholderText = "Hour:Minutes"
        question74.module = newModule7
        
        //Condition Wise
        let question75 = Question(context: self.coreDataContext)
        question75.questionId = 5
        question75.firebaseId = 54
        question75.nextQuestionId = 6
        question75.question = "Currently, what information sources do you usually turn to for news about current issues and events?"
        switch condition{
        case "a":
            question75.answerType = "TextView"
        case "b":
            question75.answerType = "TextView"
            question75.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question75.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question75.answerType = "Voice"
            question75.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question75.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question75.answerType = "TextAndVoice"
            question75.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question75.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
        default:
            question75.answerType = "TextView"
        }
        question75.module = newModule7
        
        let question76 = Question(context: self.coreDataContext)
        question76.questionId = 6
        question76.firebaseId = 55
        question76.nextQuestionId = 7
        question76.question = "When thinking about a job, what factors are important to you?"
        switch condition{
        case "a":
            question76.answerType = "TextView"
        case "b":
            question76.answerType = "TextView"
            question76.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question76.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question76.answerType = "Voice"
            question76.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question76.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question76.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question76.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question76.answerType = "TextAndVoice"
        default:
            question76.answerType = "TextView"
        }
        question76.placeholderText = "Specify"
        question76.module = newModule7
        
        let question77 = Question(context: self.coreDataContext)
        question77.questionId = 7
        question77.firebaseId = 56
        question77.nextQuestionId = 8
        question77.question = "In your own words, what are some lessons that humankind should learn from the coronavirus outbreak?"
        switch condition{
        case "a":
            question77.answerType = "TextView"
        case "b":
            question77.answerType = "TextView"
            question77.questionItalicText = "Instructions: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box."
            question77.moduleStartInfo = "Please use the dictation button on your keyboard to answer this question."
        case "c":
            question77.answerType = "Voice"
            question77.questionItalicText = "Instructions: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            question77.moduleStartInfo = "Please use the voice recording button below to record a voice answer."
        case "d":
            question77.answerType = "TextAndVoice"
            question77.moduleStartInfo =
                "There are a few ways you can answer this question: 1) using the text box to type in your answer, 2) using the dictation button to turn your voice into text, 3) using the voice recording button below to submit your answer. Please feel free to choose any one of them to answer this question."
            question77.questionItalicText = "Dictation button: tap anywhere in the text box to bring up your keyboard, and then tap on the microphone button on the bottom right corner to start speaking. When you are done speaking, tap the keyboard button to stop dictation. Your answer should appear in the text box.\nVoice record button: tap the recording button below and start speaking, once you are done, tap the button again to stop recording. You can click on next to submit your voice answer. You can’t replay your voice answer, however, you can record again and only the last recorded answer will be submitted."
            
        default:
            question77.answerType = "TextView"
        }
        question77.module = newModule7
        
        // Debreifing Question
        let question78 = Question(context: self.coreDataContext)
        question78.questionId = 8
        question78.firebaseId = 57
        question78.nextQuestionId = 9
        question78.question = "How easy or difficult was it for you to complete this study?"
        question78.answerType = "BCQ"
        question78.answerChoices = ["Very easy",
                                    "Somewhat easy",
                                    "Neither easy nor difficult",
                                    "Somewhat difficult",
                                    "Very difficult"]
        question78.module = newModule7
        question78.moduleStartInfo = "This is the final section of the study. It has questions about your experience with the study. When answering these questions, please consider all parts of the survey, from the first section to the current section."
        
        let question79 = Question(context: self.coreDataContext)
        question79.questionId = 9
        question79.firebaseId = 58
        question79.nextQuestionId = 10
        question79.question = "Why did you say that?"
        question79.answerType = "TextView"
        question79.module = newModule7
        
        
        let question710 = Question(context: self.coreDataContext)
        question710.questionId = 10
        question710.firebaseId = 59
        question710.nextQuestionId = 11
        question710.question = "How many minutes do you think that you spent on this study?"
        question710.answerType = "Numeric"
        question710.placeholderText = "Number of minutes"
        question710.module = newModule7
        
        let question711 = Question(context: self.coreDataContext)
        question711.questionId = 11
        question711.firebaseId = 60
        question711.nextQuestionId = 12
        question711.question = "Did you experience any technical difficulties with the survey? Please tell us what problems you encountered and (if applicable) how you solved them."
        question711.answerType = "TextView"
        question711.module = newModule7
        
        let question712 = Question(context: self.coreDataContext)
        question712.questionId = 12
        question712.nextQuestionId = 13
        question712.firebaseId = 61
        question712.question = "Did you do any of the following activities while completing any part of the survey? Please select all that apply."
        question712.answerType = "MCQ"
        question712.answerChoices = ["Watch TV or videos",
                                    "Listen to music",
                                    "Chat with other people (on the phone, face-to-face)",
                                    "Text with other people",
                                    "Prepare a meal, eat or drink",
                                    "Travel on foot or in a vehicle",
                                    "Idle (e.g., wait for someone, in line for an appointment)",
                                    "Other activities"]
        question712.placeholderText = "Specify"
        question712.otherOption = ["Other activities"]
        question712.module = newModule7
        
        let question713 = Question(context: self.coreDataContext)
        question713.questionId = 13
        question713.nextQuestionId = 14
        question713.firebaseId = 62
        question713.question = "Where were you when you were working on the survey? Please select all that apply."
        question713.questionItalicText = "Please consider where you were when completing all parts of the survey, from the first section to the current section."
        question713.answerType = "MCQ"
        question713.answerChoices = ["At home",
                                   "At work",
                                   "In transit",
                                   "Other location"]
        question713.otherOption = ["Other location"]
        question713.placeholderText = "Specify"
        question713.module = newModule7
        
        //Experimental Conditions
        let appVoiceCondition = "\(appCondition)\(condition)"
        
        if (appCondition == "1") {
            let question714 = Question(context: self.coreDataContext)
            question714.questionId = 14
            question714.nextQuestionId = 15
            question714.firebaseId = 63
            question714.question = "How would you rate the amount of time it took to complete each module?"
            question714.answerType = "BCQ"
            question714.answerChoices = ["They were too long",
                                       "They were about right",
                                       "They were too short"
                                        ]
            question714.module = newModule7
            
            let question715 = Question(context: self.coreDataContext)
            question715.questionId = 15
            question715.nextQuestionId = 16
            question715.firebaseId = 65
            question715.question = "For this study, we’ve been sending you a new module every other day. How often would you prefer us sending you a new module?"
            question715.answerType = "BCQ"
            question715.answerChoices = ["One module per day",
                                       "One module every other day (the current setup)",
                                       "One module per week",
                                       "One module every other week",
                                       "One module per month",
                                       "Just send all modules at once",
                                       "Some other frequencies",
                                        ]
            question715.otherOption = ["Some other frequencies"]
            question715.placeholderText = "Specify"
            question715.module = newModule7
            
            let question716 = Question(context: self.coreDataContext)
            question716.questionId = 16
            question716.nextQuestionId = 17
            question716.firebaseId = 66
            question716.question = "If you were to complete another survey using this app, would you prefer the current format (having different modules pushed to your app regularly) or having all modules available on day 1?"
            question716.answerType = "BCQ"
            question716.answerChoices = ["Having different modules pushed to my app regularly",
                                       "Having all modules available on day 1",
                                       "I don’t have a preference"
                                        ]
            question716.placeholderText = "Specify"
            question716.module = newModule7
            
            if (condition == "b" || condition == "c" || condition == "d" ) {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 17
                question717.nextQuestionId = 18
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule7
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 18
                //question718.nextQuestionId = 19
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "BCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.otherOption = ["Other reason"]
                question718.placeholderText = "Specify"
                question718.module = newModule7
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 18
                //question716.nextQuestionId = 16
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule7
            }
        }
        
        if (appCondition == "2") {
            let question714 = Question(context: self.coreDataContext)
            question714.questionId = 14
            question714.nextQuestionId = 15
            question714.firebaseId = 63
            question714.question = "How would you rate the amount of time it took to complete each module?"
            question714.answerType = "BCQ"
            question714.answerChoices = ["They were too long",
                                       "They were about right",
                                       "They were too short"
                                        ]
            question714.module = newModule7
            
            let question715 = Question(context: self.coreDataContext)
            question715.questionId = 15
            question715.nextQuestionId = 16
            question715.firebaseId = 64
            question715.question = "If you were to complete another survey using this app, would you prefer the current format (having all modules available on day 1) or having different modules pushed to your app regularly (e.g., every other day)?"
            question715.answerType = "BCQ"
            question715.answerChoices = ["Having all modules available on day 1",
                                       "Having different modules pushed to my app regularly",
                                       "I don’t have a preference"
                                        ]
            question715.module = newModule7
            
            if (condition == "b" || condition == "c" || condition == "d" ) {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 16
                question717.nextQuestionId = 17
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule7
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 17
                //question718.nextQuestionId = 18
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "BCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.placeholderText = "Specify"
                question718.otherOption = ["Other reason"]
                question718.module = newModule7
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 17
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule7
            }
        }
        
        if (appCondition == "3") {
            if (condition == "b" || condition == "c" || condition == "d" ) {
                let question717 = Question(context: self.coreDataContext)
                question717.questionId = 14
                question717.nextQuestionId = 15
                question717.firebaseId = 67
                question717.question = "When answering open-ended questions earlier, did you try using any voice input features as instructed?"
                
                question717.answerType = "BCQ"
                question717.answerChoices = ["Yes, I tried using the dictation button",
                                           "Yes, I tried recording (and uploading) my voice answer",
                                           "Yes, I tried using both",
                                           "No, I didn’t try any of the features mentioned"
                                            ]
                question717.skipLogic = true
                question717.skipToQuestionId = 18
                question717.skipAnswer = ["Yes, I tried using the dictation button",
                                          "Yes, I tried recording (and uploading) my voice answer",
                                          "Yes, I tried using both"]
                question717.module = newModule7
                
                let question718 = Question(context: self.coreDataContext)
                question718.questionId = 15
                //question718.nextQuestionId = 16
                question718.firebaseId = 68
                question718.question = "What prevented you from using voice input features? Please select all that apply."
                question718.answerType = "MCQ"
                question718.answerChoices = ["I don’t know how to use them",
                                           "I was not in a private environment when answering this survey",
                                           "The voice input features aren’t well designed",
                                           "I just like typing on my phone",
                                           "I wasn’t going to provide a long answer anyway",
                                           "Other reason"
                                            ]
                question718.placeholderText = "Specify"
                question718.otherOption = ["Other reason"]
                question718.module = newModule7
                
                let question719 = Question(context: self.coreDataContext)
                question719.questionId = 15
                question719.firebaseId = 69
                question719.question = "How helpful were the voice input features to you when answering open-ended questions in the app?"
                question719.answerType = "BCQ"
                question719.answerChoices = ["Very helpful",
                                           "Somewhat helpful",
                                           "Neither helpful nor unhelpful",
                                           "Not very helpful",
                                           "Not helpful at all"
                                            ]
                question719.module = newModule7
            }
        }
        
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
                Helper.modules = self.modules
                homeVC.surveyName = "General Economic Survey\nSurvey Modules" //self.userSurvey?.surveyName ?? ""
                self.view.removeBluerLoader()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
            
        }
        catch {
            print("Error Getting Modules From Core Data")
        }
 
    }
    
    
    
}

