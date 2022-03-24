//
//  GridSatisfyTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 15/02/2022.
//

import UIKit

protocol GridSatisfyTVCDelegate : AnyObject {
    func optionValueChanged(newValue: String, cellNumber: Int)
}

class GridSatisfyTVC: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lastView: UIView!
    
    @IBOutlet weak var fillImgView1: UIImageView!
    @IBOutlet weak var fillImgView2: UIImageView!
    @IBOutlet weak var fillImgView3: UIImageView!
    @IBOutlet weak var fillImgView4: UIImageView!
    
    @IBOutlet weak var gridLbl1: UILabel!
    @IBOutlet weak var gridLbl2: UILabel!
    @IBOutlet weak var gridLbl3: UILabel!
    @IBOutlet weak var gridLbl4: UILabel!
    
    @IBOutlet weak var questionLbl: UILabel!
    
    weak var delegate : GridSatisfyTVCDelegate?
    var cellNumber = 0
    
    
    //MARK:- LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- IBActions
    @IBAction func firstBtnTapped(_ sender: UIButton) {
        selectBtn(imgView: fillImgView1)
        optionSelected(option: gridLbl1.text ?? "")
    }
    
    @IBAction func secondBtnTapped(_ sender: UIButton) {
        selectBtn(imgView: fillImgView2)
        optionSelected(option: gridLbl2.text ?? "")
    }
    
    @IBAction func thirdBtnTapped(_ sender: UIButton) {
        selectBtn(imgView: fillImgView3)
        optionSelected(option: gridLbl3.text ?? "")
    }
    
    @IBAction func fourthBtnTapped(_ sender: UIButton) {
        selectBtn(imgView: fillImgView4)
        optionSelected(option: gridLbl4.text ?? "")
    }
    
    //MARK:- Helper Functions
    func optionSelected(option: String) {
        if let delegate = delegate {
            delegate.optionValueChanged(newValue: option, cellNumber: cellNumber)
        }
    }
    
    func setLbls(labels: [String]) {
        
        gridLbl1.text = labels[0]
        gridLbl2.text = labels[1]
        gridLbl3.text = labels[2]
        
        if (labels.count == 3) {
            hideLastCell()
            return
        }
        
        gridLbl4.text = labels[3]
    }
    
    func setQuestion(question: String?) {
        questionLbl.text = question
    }
    
    func setAnswer(index: Int) {
        switch index {
        case 0:
            selectBtn(imgView: fillImgView1)
        case 1:
            selectBtn(imgView: fillImgView2)
        case 2:
            selectBtn(imgView: fillImgView3)
        case 3:
            selectBtn(imgView: fillImgView4)
        default:
            clearAnswers()
        }
    }
    
    func selectBtn(imgView: UIImageView) {
        fillImgView1.isHidden = true
        fillImgView2.isHidden = true
        fillImgView3.isHidden = true
        fillImgView4.isHidden = true
        
        imgView.isHidden = false
    }
    
    func clearAnswers() {
        fillImgView1.isHidden = true
        fillImgView2.isHidden = true
        fillImgView3.isHidden = true
        fillImgView4.isHidden = true
    }
    
    func hideLastCell() {
        DispatchQueue.main.async {
            self.lastView.isHidden = true
            self.lastView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.stackView.layoutIfNeeded()
        }
    }
    
    
    
}
