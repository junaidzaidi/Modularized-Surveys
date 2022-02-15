//
//  HomeCompletedTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 17/01/2022.
//

import UIKit

class HomeCompletedTVC: UITableViewCell {

    @IBOutlet weak var moduleNameLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.mainView.layer.cornerRadius = 20
            self.mainView.clipsToBounds = true
            self.mainView.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.1)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
