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
    
    func fadeInFadeOut(_ time: Int, secondTime: Int) -> Void {
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.alpha = 1
        }) { (finished) in
            
            UIView.animate(withDuration: TimeInterval(secondTime)) {
                self.alpha = 0
            }
        }
        
    }
    
    func fadeOutFadeIn(_ time: Int, secondTime: Int) -> Void {
        
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
    
    func tremeTreme() {
        let fromValue = CGPoint(x: self.center.x - 10, y: self.center.y)
        let toValue = CGPoint(x: self.center.x + 10, y: self.center.y)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: fromValue)
        animation.toValue = NSValue(cgPoint: toValue)
        self.layer.add(animation, forKey: "position")
        
        
    }
    
    func arredondar() -> Void {
        self.layer.cornerRadius = 5
    }
    
    
    func enfeitaView (){
        self.layer.masksToBounds = false;
        self.layer.cornerRadius = 8; //bordas arredondadas
        self.layer.shadowOffset = CGSize(width: -2,height: 2);  //adiciona a sombra
        self.layer.shadowRadius = 5; //radio da sombra
        self.layer.shadowOpacity = 0.5;
    }
    
}
