//
//  UIViewController+Keyboard.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 11/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func goInicial() -> Void {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
