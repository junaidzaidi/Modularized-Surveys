//
//  FooterTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 14/11/2021.
//

import UIKit

protocol FooterTVCDelegate : AnyObject {
    func submitBtnTapped()
    func nextBtnTapped()
    func previousBtnTapped()
    
}

class FooterTVC: UITableViewHeaderFooterView {

    
    //MARK:- IBOutlets
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    //MARK:- Helper Variables
    
    weak var delegate : FooterTVCDelegate?
    var disablePreviousBtn = true
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        nextBtn.layer.cornerRadius = 8
        nextBtn.clipsToBounds = true
        
        previousBtn.layer.cornerRadius = 8
        previousBtn.layer.borderWidth = 1
        previousBtn.clipsToBounds = true
        
        

        setPreviousBtnInactive()
    }
    
    //MARK:- IBActions
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if let del = delegate {
            
            self.nextBtn.currentTitle == "Submit" ? del.submitBtnTapped() : del.nextBtnTapped()
        }
    }
    
    @IBAction func previousBtnTapped(_ sender: UIButton) {
        if let del = delegate {
            del.previousBtnTapped()
        }
    }
    
    //MARK:- Helper Functions
    
    func setPreviousBtnActive() {
        previousBtn.isEnabled = true
        previousBtn.layer.borderColor = UIColor.systemBlue.cgColor
        previousBtn.setTitleColor(.systemBlue, for: .disabled)

    }
    
    func setPreviousBtnInactive() {
        previousBtn.isEnabled = false
        previousBtn.layer.borderColor = UIColor.opaqueSeparator.cgColor
        previousBtn.setTitleColor(.opaqueSeparator, for: .disabled)
    }
    
    func setNextBtnToProceed() {
        nextBtn.setTitle("Submit", for: .normal)
    }
}
