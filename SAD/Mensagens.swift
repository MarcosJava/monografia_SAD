//
//  Mensagens.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 23/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit

class MensagensUtil {
    
    func alertaSucesso(titulo: String, mensagem: String, view: UIViewController){
        let alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    
}
