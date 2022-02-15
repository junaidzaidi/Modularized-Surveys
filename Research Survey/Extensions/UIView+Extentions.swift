//
//  UIView+Extetios.swift
//  Distributor App
//
//  Created by Junaid Zaidi on 11/03/2021.
//  Copyright © 2021 Junaid Zaidi. All rights reserved.
//

import UIKit
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius)
        self.layer.masksToBounds = false
        self.layer.shadowColor =  color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowOpacity = opacity
        //self.layer.shadowRadius = radius
        
        self.layer.shadowPath = shadowPath.cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        //layer.shadowColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1).cgColor
        layer.shadowOpacity = 0.10
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 12
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: frame)
        self.addSubview(blurLoader)
    }

    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}

class BlurLoader: UIView {

    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
