//
//  TextTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 30/10/2021.
//

import UIKit

protocol TextTVCDelegate : AnyObject {
    func textFieldValueChanged(newValue: String)
}

class TextTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textFld: UITextField!
    
    weak var delegate : TextTVCDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textFld.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let del = delegate {
            del.textFieldValueChanged(newValue: textField.text ?? "")
        }
    }
    
}
