//
//  ViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 19/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    
    @IBOutlet weak var txtError: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        self.btnEntrar.arredondar()
        self.btnEntrar.enfeitaView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let usuario = Usuario()
        let realm = try! Realm()
        _ = usuario.hasUsuarioLogado(realm: realm)
        
        self.txtError.isHidden = true
        
        if usuario.logado {
            print(usuario)
            irDashboard()
        }
    }
    
    
    
    @IBAction func entrar(_ sender: Any) {
        guard let email = txtEmail.text, let senha = txtSenha.text else {
            showError()
            return
        }
        
        if email == "usuario@teste.com" && senha == "123"{
            irDashboard()
        } else {
            let usuario = Usuario()
            let valor = usuario.contemUsuario(email, senha: senha)
            if(valor){
                let realm = try! Realm()
                usuario.putUsuarioLogado(realm: realm)
                irDashboard()
            } else {
                showError()
            }
        }
    }
    
    func showError() {
        self.txtError.isHidden = false
        self.txtError.boingView()
        self.btnEntrar.tremeTreme()
        
    }
  
    func irDashboard() -> Void {
        self.performSegue(withIdentifier: "goDashboard", sender: nil)
    }
    
}
