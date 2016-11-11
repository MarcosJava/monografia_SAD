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
    
    @IBOutlet weak var txtError: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        arredondarButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let usuario = Usuario()
        _ = usuario.hasUsuarioLogado()
        
        if usuario.logado {
            print(usuario)
            usuarioDTO = UsuarioDTO(with: usuario)
            irDashboard()
        }
    }
    
    
    
    func arredondarButton() -> Void {
        btnEntrar.layer.cornerRadius = 5
    }
    
    
    @IBAction func entrar(_ sender: Any) {
        
        if txtEmail != nil && txtSenha != nil{
            if txtEmail.text != nil && txtSenha.text != nil {
                let usuario = Usuario()
                let valor = usuario.contemUsuario(email: txtEmail.text!, senha: txtSenha.text!)
                
                print("contem usuario : \(valor) do usuario \(usuario)" )
                
                if(valor){
                    usuario.putUsuarioLogado()
                    irDashboard()
                } else {
                    
                    showError()
                }
                
            } else {
                showError()
            }
            
        } else {
            showError()
        }
        
        
    }
    
    func showError() {
        self.txtError.isHidden = false
        self.txtError.boingView()
        
    }
  
    func irDashboard() -> Void {
        self.performSegue(withIdentifier: "goDashboard", sender: nil)
    }
    
}
