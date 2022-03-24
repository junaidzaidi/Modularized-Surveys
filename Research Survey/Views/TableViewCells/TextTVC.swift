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

class TextTVC: UITableViewCell, UITextFieldDelegate, UITextInputDelegate {
    func selectionWillChange(_ textInput: UITextInput?) {
        print("SelectionWillChange")
    }
    
    func selectionDidChange(_ textInput: UITextInput?) {
        print("SelectionDidChange")
    }
    
    func textWillChange(_ textInput: UITextInput?) {
        print("TextWillChange")
    }
    
    func textDidChange(_ textInput: UITextInput?) {
        print("TextDidChange")
    }
    func dictationRecordingDidEnd() {
        print("UITextInput Dictation ended")
    }
    

    @IBOutlet weak var textFld: UITextField!
    
    weak var delegate : TextTVCDelegate?
    
    var dictationFeature = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textFld.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeInputMode(sender:)), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
    }

    @objc func changeInputMode(sender : NSNotification) {
        let primaryLanguage = textFld.textInputMode?.primaryLanguage

        if primaryLanguage != nil {
            var _:NSLocale = NSLocale(localeIdentifier: primaryLanguage!)
            if primaryLanguage == "dictation" {
               
                dictationFeature = true
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let del = delegate {
            
            dictationFeature ? del.textFieldValueChanged(newValue: "Dictation: \(textField.text ?? "")")
                : del.textFieldValueChanged(newValue: "\(textField.text ?? "")")

        }
    }
    
    func setText(text: String) {
        var savedText = text
        
        if savedText.contains("Voice:") {
           return
        }
    
        if savedText.contains("Dictation:") {
            dictationFeature = true
            savedText = savedText.replacingOccurrences(of: "Dictation: ", with: "")
        }
        textFld.text = savedText
    }
    
    func setPlaceholder(placeholderText: String?) {
        textFld.placeholder = placeholderText
    }
}


