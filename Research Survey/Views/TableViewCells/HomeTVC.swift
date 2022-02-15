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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            //self.progressBar.transform = self.progressBar.transform.scaledBy(x: 0, y: 0)
            self.progressBar.transform = self.progressBar.transform.scaledBy(x: 1, y: 4)
            self.mainView.layer.cornerRadius = 20
            self.mainView.clipsToBounds = true
            self.shadowView.layoutIfNeeded()
            self.shadowView.dropShadow(color: UIColor.black, opacity: 0.1, offSet: CGSize(width: 4, height: 4), radius: 20, scale: false)
           
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProgressBarProgress(progress: Float) {
        DispatchQueue.main.async {
            self.progressBar.progress = progress
        }
    }
    
    /*
    func markCellCompleted() {
        DispatchQueue.main.async {
            self.mainView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            self.progressView.isHidden = true
            self.progressBarViewHeightConst.constant = 20
            self.layoutIfNeeded()
        }
    }
    
    func markCellDefault() {
        DispatchQueue.main.async {
            self.mainView.backgroundColor = .white
            self.progressView.isHidden = false
            self.progressBarViewHeightConst.constant = 55.5
            self.layoutIfNeeded()
        }
    }
    */
}
