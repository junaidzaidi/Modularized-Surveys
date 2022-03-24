//
//  MultipleChoiceTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 30/10/2021.
//

import UIKit

protocol MultipleChoiceTVCDelegate : AnyObject {
    func selectionChanged(choice: String, selected: Bool)
}

class MultipleChoiceTVC: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var checkImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //MARK:- Helper Variables
    weak var delegate : MultipleChoiceTVCDelegate?
    
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
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
    func setChoiceName(name: String) {
        nameLbl.text = name
    }
    
    func setActive(state: Bool) {
        checkImgView.image = state ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        checkImgView.tintColor = .systemBlue
    }
    
}
