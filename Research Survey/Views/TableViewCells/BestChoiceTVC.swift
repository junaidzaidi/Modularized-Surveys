//
//  BestChoiceTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 30/10/2021.
//

import UIKit

class BestChoiceTVC: UITableViewCell {

    
    //MARK:- IBOutlets
    @IBOutlet weak var radioBtnFilled: UIImageView!
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
    @IBAction func RadioBtnTapped(_ sender: UIButton) {
        radioBtnFilled.isHidden = radioBtnFilled.isHidden == true ? false : true
    }
    
    //MARK:- Helper Function
    func setChoiceName(name: String) {
        nameLbl.text = name
    }
    
}
