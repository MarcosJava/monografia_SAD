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

    var usuarioDAO:UsuarioManager!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    
    override func viewDidLoad() {
        usuarioDAO = UsuarioManager()
        hideKeyboardWhenTappedAround()
        arredondarButton()
    }
    
    func arredondarButton() -> Void {
        btnEntrar.layer.cornerRadius = 5
    }
    
    @IBAction func entrar(_ sender: Any) {
        
        if txtEmail != nil && txtSenha != nil{
            if txtEmail.text != nil && txtSenha.text != nil {
                let usuario = Usuario()
                let valor = usuario.contemUsuario(email: txtEmail.text!, senha: txtSenha.text!)
                if(valor){
                    irDashboard()
                }
                
                
            }
        }
        
        
    }
    
    
    @IBAction func cadastrar(_ sender: Any) {
        
    }
    
    func irDashboard() -> Void {
        self.performSegue(withIdentifier: "goDashboard", sender: nil)
    }
    
}
