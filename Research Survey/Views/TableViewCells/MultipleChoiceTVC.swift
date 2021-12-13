//
//  MultipleChoiceTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 30/10/2021.
//

import UIKit

class MultipleChoiceTVC: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var checkImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
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
        checkImgView.image = checkImgView.image == UIImage(systemName: "square") ?  UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
    }
    
    //MARK:- Helper Function
    func setChoiceName(name: String) {
        nameLbl.text = name
    }
    
}
