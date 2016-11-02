//
//  Regex.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 02/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit


class Validador {
    
    
    let REGEX_EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    func emailValido(email: String) -> Bool {
        
        let regex = try! NSRegularExpression(pattern: REGEX_EMAIL, options: .caseInsensitive)

        let resultado = regex.numberOfMatches(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: email.characters.count))
        
        if (resultado == 0){
            return false
        } else {
            return true
        }

    }
}


