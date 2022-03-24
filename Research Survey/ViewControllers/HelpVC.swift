//
//  HelpVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 23/03/2022.
//

import UIKit

class HelpVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.headerView.dropShadow()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
