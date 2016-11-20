//
//  DashboardViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

//var usuarioDTO:UsuarioDTO?


class DashboardViewController: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
        
        addNavigatiorButton()
    }
    
    func addNavigatiorButton() -> Void {
        
        let buttonRight = UIBarButtonItem(title: "Sair", style: .done, target: self, action: #selector(DashboardViewController.logout))
        self.navigationItem.rightBarButtonItem = buttonRight;
        self.navigationItem.rightBarButtonItem?.title = "Logout"
        
    }
    
    func logout() {
        
        
        let realm = try! Realm()

        let usuario = Usuario()
        _ = usuario.hasUsuarioLogado(realm: realm)
        usuario.logado = false;
        usuario.update(realm: realm)
        
    
        goInicial()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
