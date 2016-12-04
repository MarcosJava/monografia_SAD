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
    
    let mensagem = MensagensUtil()
    
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
    
    
    
    func completeMaxOrMinGlicemia(max: Bool) -> DeatalheGlicemia? {
        
        guard let maxGlicemia = usuario?.glicemias.count else {
            mensagem.alertaSucesso(titulo: "Atenção", mensagem: "Para realizar esta função necessita de 2 ou mais exames", view: self)
            return nil;
        }
        
        if maxGlicemia > 0 {
            
            var glicemia:Glicemia
            
            if max {
                 glicemia = usuario!.glicemias.sorted(by: {$0.valorGlicemico > $1.valorGlicemico}).first!
            } else {
                 glicemia = usuario!.glicemias.sorted(by: {$0.valorGlicemico < $1.valorGlicemico}).first!
            }
            
            let configuracao = Configuracao()
            configuracao.id = glicemia.configuracao
            configuracao.configuracaoComId(realm: try! Realm())
            
            let glicemiaValue = glicemia.valorGlicemico.description
            let txHormonalValue = glicemia.taxaHormonal.description
            let pressaoValue = "\(glicemia.pressaoMenor) por \(glicemia.pressaoMaior)"
            let observacaoValue = glicemia.observacao
            
            
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            
            let dtExameValue = df.string(from: glicemia.dtCadastro as Date)
            let maiorConfigValue = configuracao.maiorGlicemia.description
            let menorConfigValue = configuracao.menorGlicemia.description
            
            
            
            let detalhes = DeatalheGlicemia(glicemia: glicemiaValue, taxaHormonal: txHormonalValue, pressao: pressaoValue, observacao: observacaoValue, dtExame: dtExameValue, maiorGlicemia: maiorConfigValue, menorGlicemia: menorConfigValue)
            
            return detalhes
            
            
        } else {
            mensagem.alertaSucesso(titulo: "Atenção", mensagem: "Para realizar esta função necessita de 2 ou mais exames", view: self)
            return nil
        }

    }
    
    
    @IBAction func maiorGlicemia(_ sender: Any) {
        guard let detalhe = completeMaxOrMinGlicemia(max: true) else { return }
        let vcDetalhes = DetalheExameViewController(detalhesGlicemico: detalhe)
        navigationController?.pushViewController(vcDetalhes, animated: true)
        
        
    }
    @IBAction func menorGlicemia(_ sender: Any) {
        guard let detalhe = completeMaxOrMinGlicemia(max: false) else { return }
        let vcDetalhes = DetalheExameViewController(detalhesGlicemico: detalhe)
        navigationController?.pushViewController(vcDetalhes, animated: true)
        
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
