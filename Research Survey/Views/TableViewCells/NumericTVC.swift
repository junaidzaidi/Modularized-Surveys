//
//  NumericTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 30/10/2021.
//

import UIKit

protocol NumericTVCDelegate : AnyObject {
    func numericFieldValueChanged(newValue: String)
}

class NumericTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textFld: UITextField!
    
    weak var delegate: NumericTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textFld.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let del = delegate {
            del.numericFieldValueChanged(newValue: textField.text ?? "")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
