//
//  FeedbackVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 23/03/2022.
//

import UIKit

class FeedbackVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.headerView.dropShadow()
        }
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 0.75).cgColor
        textView.layer.cornerRadius = 4
        textView.clipsToBounds = true
        
        submitBtn.layer.cornerRadius = 8
        submitBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        let text  = textView.text
        let params = [
            "username": UserDefaults.standard.string(forKey: "LoggedInUsername"),
            "password": UserDefaults.standard.string(forKey: "UserPassword"),
            "feedback": text
        ] as [String : AnyObject]
        
        _ = Helper.addFeedback(parameters: params)
        
        // Create new Alert
        var dialogMessage = UIAlertController(title: "Feeback Submitted", message: "Your feedback is submitted successfully", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)

        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    

}
