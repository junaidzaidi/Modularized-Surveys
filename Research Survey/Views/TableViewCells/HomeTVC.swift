//
//  HomeTVC.swift
//  Research Survey
//
//  Created by Junaid Zaidi on 28/10/2021.
//

import UIKit

class HomeTVC: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var moduleName: UILabel!
    @IBOutlet weak var questionStatus: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var remainingTime: UILabel!
    
    @IBOutlet weak var progressBarViewHeightConst: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.progressBar.transform = self.progressBar.transform.scaledBy(x: 0, y: 0)
            //self.progressBar.transform = self.progressBar.transform.scaledBy(x: 1, y: 3)
            self.mainView.layer.cornerRadius = 20
            self.mainView.clipsToBounds = true
            self.progressView.isHidden = true
            self.progressBarViewHeightConst.constant = 20
            self.shadowView.layoutIfNeeded()
            self.shadowView.dropShadow(color: UIColor.black, opacity: 0.1, offSet: CGSize(width: 0, height: 0), radius: 20, scale: false)
           
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
