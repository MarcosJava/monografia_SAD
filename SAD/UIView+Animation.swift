//
//  UIView+Extensions.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 11/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func fadeInFadeOut(time: Int, secondTime: Int) -> Void {
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.alpha = 1
        }) { (finished) in
            
            UIView.animate(withDuration: TimeInterval(secondTime)) {
                self.alpha = 0
            }
        }
        
    }
    
    func fadeOutFadeIn(time: Int, secondTime: Int) -> Void {
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.alpha = 0
        }) { (finished) in
            
            UIView.animate(withDuration: TimeInterval(secondTime)) {
                self.alpha = 1
            }
        }
        
    }
    
    
    func boingView() {
        
            
            UIView.animate(withDuration: 1, animations: {
                
                self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                
            }) { (finish) in
                
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        
                    }) { (finish) in
                        UIView.animate(withDuration: 0.5, animations: {
                            
                            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            
                        })
                    }
            
                
        }
    }
    
    
    
}
