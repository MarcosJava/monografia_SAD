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

class DashboardViewController: UIViewController {
    var usuario:Usuario?
    
    @IBOutlet weak var maiorTaxaBtn: UIButton!
    @IBOutlet weak var maiorTextLabel: UILabel!
    @IBOutlet weak var imgMaiorLabel: UILabel!
    
    @IBOutlet weak var menorTaxaBtn: UIButton!
    @IBOutlet weak var menorTextLabel: UILabel!
    @IBOutlet weak var imgMenorLabel: UILabel!
    
    @IBOutlet weak var pendenciaBtn: UIButton!
    @IBOutlet weak var configuracaoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
        addNavigatiorButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        usuarioLogado()
        verificarPendencia()
        addRecordesGlicemicos()
    }
    
    func addNavigatiorButton() -> Void {
        let buttonRight = UIBarButtonItem(title: "Sair", style: .done, target: self, action: #selector(DashboardViewController.logout))
        self.navigationItem.rightBarButtonItem = buttonRight;
        self.navigationItem.rightBarButtonItem?.title = "Logout"
        
    }
    
    func usuarioLogado(){
        usuario = Usuario()
        let realm = try! Realm()
        _ = usuario?.hasUsuarioLogado(realm: realm)
    }
    
    func verificarPendencia(){
        if (usuario?.configuracao)! > 0 {
            configuracaoShow(false)
        } else {
            configuracaoShow(true)
        }
    }
    
    func configuracaoShow(_ show:Bool){
        pendenciaBtn.isHidden = !show
        configuracaoLabel.isHidden = !show
    }
    
    func addRecordesGlicemicos(){
        
        guard let glicemias = usuario?.glicemias else {return }
        
        if glicemias.count > 2 {
            
            let valores = glicemias.map{property in property.valorGlicemico}
            let min = valores.min()
            let max = valores.max()
            
            maiorTextLabel.text = max?.description
            menorTextLabel.text = min?.description
        } else {
            maiorTextLabel.text = "0"
            menorTextLabel.text = "0"
        }
        
    }
    
    func logout() {
        let realm = try! Realm()

        let usuario = Usuario()
        _ = usuario.hasUsuarioLogado(realm: realm)
        usuario.logado = false;
        usuario.update(realm: realm)
        goInicial()
    }
    
}
