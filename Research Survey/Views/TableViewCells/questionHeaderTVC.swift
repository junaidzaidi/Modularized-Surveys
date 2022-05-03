//
//  questionHeaderTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 07/04/2022.
//

import UIKit

class questionHeaderTVC: UITableViewHeaderFooterView {

    @IBOutlet weak var moduleStartLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var italicLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionLbl.font = questionLbl.font.bold
        italicLbl.font = italicLbl.font.italic
    
    }
    
    func changeLblsFonts() {
        moduleStartLbl.font = moduleStartLbl.font.bold
        questionLbl.font = nil
        
    }
    
    func setLbls(moduleStart: String?, question:String?, italic: String?) {
        moduleStartLbl.text = moduleStart
        questionLbl.text = question
        italicLbl.text = italic
        
        moduleStartLbl.isHidden = moduleStart == nil
        italicLbl.isHidden = italic == nil
    }

}
