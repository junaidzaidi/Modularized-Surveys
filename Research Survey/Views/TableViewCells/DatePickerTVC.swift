//
//  DatePickerTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 21/03/2022.
//

import UIKit
import MonthYearPicker

protocol DatePickerTVCDelegate : AnyObject {
    func dateFieldValueChanged(newValue: String)
}

class DatePickerTVC: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textFld: UITextField!
    
    weak var delegate : DatePickerTVCDelegate?
    
    let datePicker = UIDatePicker()
    var picker : MonthYearPickerView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        createDatePicker()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func createToolbar() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(DatePickerTVC.donePressed(_:)))
//        toolbar.setItems([doneBtn], animated: true)
//        return toolbar
        picker = MonthYearPickerView(frame: CGRect(origin: CGPoint(x: 0, y: (self.bounds.height - 216) / 2), size: CGSize(width: self.bounds.width, height: 216)))
        picker?.maximumDate = Date()
        picker?.minimumDate = Calendar.current.date(byAdding: .year, value: -50, to: Date())
        picker?.addTarget(self, action: #selector(DatePickerTVC.donePressed(_:)), for: .valueChanged)
        textFld.inputView = picker
        //view.addSubview(picker)
    }
    
    func createDatePicker() {
//        datePicker.datePickerMode = .date
//        datePicker.preferredDatePickerStyle = .wheels
//        textFld.inputView = datePicker
//        textFld.inputAccessoryView = createToolbar()
        createToolbar()
    }
    
    @objc func donePressed(_ sender:UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        var dateText = dateFormatter.string(from: picker?.date ?? Date())
        dateText = "\(dateText.split(separator: " ")[0]), \(dateText.split(separator: " ")[2])"
        self.textFld.text = dateText
        if let del = delegate {
            del.dateFieldValueChanged(newValue: self.textFld.text ?? "")
        }
    }
    
    func setText(text: String?) {
        textFld.text = text
    }
    
    func setPlaceholder(placeholderText: String?) {
        textFld.placeholder = placeholderText
    }
    
    
}
