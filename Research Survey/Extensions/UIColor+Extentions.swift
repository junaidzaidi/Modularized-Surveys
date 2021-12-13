//
//  UIColor+Extentions.swift
//  Distributor App
//
//  Created by Junaid Zaidi on 13/06/2021.
//  Copyright © 2021 Junaid Zaidi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //Colors
    static let primaryPurple = UIColor(red: 78/255, green: 52/255, blue: 138/255, alpha: 1)
    static let primaryPink = UIColor(red: 211/255, green: 54/255, blue: 171/255, alpha: 1)
    
    static let secondaryPurple =  UIColor(red: 142/255, green: 36/255, blue: 70/255, alpha: 1)
    static let secondaryPink = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1)
    
    
    //Customisations
    static let gradientStart = primaryPurple
    static let gradientEnd = primaryPink
    
    //For Distributor Dashboard Segment Tiles
    static let textAndImgColor = secondaryPink
    
    //For TabBar Tint
    static let tabBarBackgroundColor = UIColor.white
    static let tabBarTintColor = secondaryPink
}
