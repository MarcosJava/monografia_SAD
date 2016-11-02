//
//  ViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 19/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin


class ViewController: UIViewController{

    let usuarioManager = UsuarioManager()
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    
    override func viewDidLoad() {
        arredondarButton()
    }
    
    func arredondarButton() -> Void {
        btnEntrar.layer.cornerRadius = 5
    }
    
    @IBAction func entrar(_ sender: Any) {
        
    }
    
    
    @IBAction func cadastrar(_ sender: Any) {
        
    }
    
    func irDashboard() -> Void {
        self.performSegue(withIdentifier: "goDashboard", sender: nil)
    }
    
}
