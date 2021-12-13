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
    @IBOutlet weak var moduleName: UILabel!
    @IBOutlet weak var questionStatus: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var remainingTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.progressBar.transform = self.progressBar.transform.scaledBy(x: 1, y: 4)
            self.mainView.layer.cornerRadius = 20
            self.mainView.clipsToBounds = true
            self.shadowView.dropShadow(color: UIColor.black, opacity: 0.1, offSet: CGSize(width: 4, height: 4), radius: 20, scale: false)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
