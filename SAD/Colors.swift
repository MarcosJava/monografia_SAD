//
//  Colors.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 01/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit


class Colors {
    
    func getCyan() -> UIColor {
        return UIColor(netHex:0x00ACC1)
    }
    
    func getLightGreen() -> UIColor {
        return UIColor(netHex: 0x9CCC65)
    }
    
    func getBluePrincipal() -> UIColor {
        return UIColor(netHex: 0x2196F3)
    }
    
    func getBluePrincipalClear() -> UIColor {
        return UIColor(netHex: 0xBBE7F8)
    }
    
}


extension UIColor {

    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}
