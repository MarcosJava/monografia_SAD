//
//  UITextView+Designer.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 12/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func changeColorPlaceholder(_placeholder: String, color: UIColor ) {
        
        let placeholderString = NSAttributedString(string: _placeholder, attributes: [NSForegroundColorAttributeName: color])
        self.attributedPlaceholder = placeholderString
        
        
    }
    
    
}
