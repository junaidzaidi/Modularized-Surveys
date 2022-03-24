//
//  OtherMCQTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 24/01/2022.
//

import UIKit

protocol otherTVCDelegate: AnyObject {
    func otherTextChanged(newValue: String)
}
class OtherMCQTVC: UITableViewCell, UITextFieldDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var checkImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var txtFldViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var txtFldView: UIView!
    @IBOutlet weak var otherTxtFld: UITextField!
    
    @IBOutlet weak var radioBtnFilled: UIImageView!
    //MARK:- Helper Variables
    weak var delegate : otherTVCDelegate?
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        txtFldViewHeightConst.constant = 0
        txtFldView.isHidden = true
        otherTxtFld.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- IBActions
    @IBAction func checkBtnTapped(_ sender: UIButton) {
        
        /*
        if let del = delegate {
            del.selectionChanged(choice: nameLbl.text ?? "", selected: checkImgView.image == UIImage(systemName: "checkmark.square.fill"))
        }
        */
    }
    
    //MARK:- Helper Function
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let del = delegate {
            
            del.otherTextChanged(newValue: "-101:\(textField.text ?? "")")

        }
    }
    
    func setChoiceName(name: String) {
        nameLbl.text = name
    }
    
    func setActiveCheck(state: Bool) {
        checkImgView.image = state ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        checkImgView.tintColor = .systemBlue
            txtFldViewHeightConst.constant = state ? 32 : 0
            txtFldView.isHidden = state ? false : true
    }
    
    func setActiveRadio(state: Bool) {
        radioBtnFilled.isHidden = state ? false : true
        txtFldViewHeightConst.constant = state ? 32 : 0
        txtFldView.isHidden = state ? false : true
    }
    
    func setPlaceholder(text: String?) {
        otherTxtFld.placeholder = text
    }
    
    func setText(text: String?) {
        var newText = text?.replacingOccurrences(of: "-101:", with: "")
        otherTxtFld.text = newText
    }
    
}
