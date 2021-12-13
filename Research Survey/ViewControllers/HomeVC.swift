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
    
    @IBOutlet weak var surveyNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeView: UIView!
    //MARK:- Helper Variables
    var modules : [Module]? = nil
    var surveyName = ""
    
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
        surveyNameLbl.text = surveyName
    }
    //MARK:- IBActions
    @IBAction func settingBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SettingVC") as? SettingVC ?? SettingVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    //MARK:- Helper Functions
    func setup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "HomeTVC", bundle: nil), forCellReuseIdentifier: "HomeTVC")
        tableView.register(UINib(nibName: "ReleaseDateTVC", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReleaseDateTVC")
        
    }
    
    func configure() {
        
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as? HomeTVC ?? HomeTVC()
        //cell.mainView.backgroundColor = indexPath.row > 5 ? .white : UIColor(red: 178/255, green: 220/255, blue: 255/255, alpha: 0.90)
        cell.moduleName.text = modules?[indexPath.row].moduleName ?? ""
        cell.questionStatus.text = "1/\(modules?[indexPath.row].questions?.count ?? 0)"
        
        cell.mainView.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReleaseDateTVC") as? ReleaseDateTVC ?? ReleaseDateTVC()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let question = modules?[indexPath.row].questions?.first(where: {$0.isFirst == true})
        //let question = modules?[indexPath.row].questions?[0]
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionVC") as? QuestionVC ?? QuestionVC()
        viewController.module = modules?[indexPath.row]
        viewController.question = question
        viewController.questionNumber = 1
        viewController.moduleName = modules?[indexPath.row].moduleName ?? ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    
}
