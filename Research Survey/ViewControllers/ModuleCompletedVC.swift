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
    
    //MARK:- Helper Variable
    
    var module : Module? = nil
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        
    }
}
