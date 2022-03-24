//
//  TextViewTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 22/03/2022.
//

import UIKit
protocol TextViewTVCDelegate : AnyObject {
    func textViewValueChanged(newValue: String)
}

class TextViewTVC: UITableViewCell, UITextInputDelegate, UITextViewDelegate  {

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
    

    @IBOutlet weak var textView: UITextView!
    
    weak var delegate : TextViewTVCDelegate?
    
    var dictationFeature = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeInputMode(sender:)), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 0.75).cgColor
        textView.layer.cornerRadius = 4
        textView.clipsToBounds = true
    }

    @objc func changeInputMode(sender : NSNotification) {
        let primaryLanguage = textView.textInputMode?.primaryLanguage

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
    
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        if let del = delegate {
            
            dictationFeature ? del.textViewValueChanged(newValue: "Dictation: \(textView.text ?? "")")
                : del.textViewValueChanged(newValue: "\(textView.text ?? "")")

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
        textView.text = savedText
    }
    
    func setPlaceholder(placeholderText: String?) {
        //textView.textColor = .lightGray
        //textView.text = "Type your thoughts here..."

    }
    
}
