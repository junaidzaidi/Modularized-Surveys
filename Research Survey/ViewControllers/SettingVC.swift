//
//  SettingVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 11/11/2021.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.headerView.dropShadow()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func helpBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "HelpVC") as? HelpVC ?? HelpVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func feedbackBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "FeedbackVC") as? FeedbackVC ?? FeedbackVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func dataPrivacyBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DataPrivacyVC") as? DataPrivacyVC ?? DataPrivacyVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
