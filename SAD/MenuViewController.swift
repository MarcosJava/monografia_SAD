//
//  MenuViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var tableView: UITableView!
    var arrayMenu = [MenuEnum]()
    var usuario:Usuario! = nil
    
    let mensagem = MensagensUtil()
    let colors:Colors = Colors()
    
    var minGlicemia:Double = 0
    var maxGlicemia:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capturaUsuario()
        completandoArrayMenu()
        configurandoTableView()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        capturaUsuario()
        existeMaiorOuMenor()
        tableView.reloadData()
    }
    
    func configurandoTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = colors.getBluePrincipal()
    }
    
    func capturaUsuario(){
        self.usuario = Usuario()
        let realm = try! Realm()
        _ = usuario.hasUsuarioLogado(realm: realm)
        print(usuario)
    }
    
    func completandoArrayMenu(){
        arrayMenu.append(.realizarExames)
        arrayMenu.append(.consultar)
        arrayMenu.append(.grafico)
        arrayMenu.append(.maiorGlicemia)
        arrayMenu.append(.menorGlicemia)
        arrayMenu.append(.dados)
        //arrayMenu.append(.sincronizar)
    }
    
    func existeMaiorOuMenor(){
        guard let glicemias = usuario?.glicemias else {return }
        
        if glicemias.count > 2 {
            let valores = glicemias.map{property in property.valorGlicemico}
            minGlicemia = valores.min() ?? 0
            maxGlicemia = valores.max() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let menu = arrayMenu[indexPath.row]
        if  (menu == .realizarExames && usuario.configuracao == 0) //Configuracao
                    || (menu == .maiorGlicemia && maxGlicemia == 0) //Maior
                    || (menu == .menorGlicemia && minGlicemia == 0) { //Menor
            
            cell.textLabel?.isEnabled = false
        }
        
        cell.textLabel?.text = menu.rawValue
        cell.textLabel?.font = UIFont(name: "Avenir Next", size:15)
        cell.backgroundColor = colors.getBluePrincipalClear()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.usuario != nil) {
            let menuEnum = arrayMenu[indexPath.row]
            
            switch menuEnum {
                
            case .realizarExames :
                realizandoExames()
                
            case .consultar:
                goConsultar()
                
            case .grafico:
                goGrafico()
                
            case .maiorGlicemia:
                maiorGlicemia()
                
            case .menorGlicemia:
                menorGlicemia()
                
            case .dados:
                goConfiguracao()
                
            case .sincronizar:
                realizaSincronizacao()
            }
            self.tableView.deselectRow(at: indexPath, animated: true)

        }
    }
    
    func realizaSincronizacao(){
        let _ = FirebaseConfig()
    }
    
    func realizandoExames(){
        
        if self.usuario.configuracao != 0 {
            self.goRealizarExames()
        } else {
            mensagem.alertaSucesso(titulo: "Configuração", mensagem: "Para realizar o exame e necessario completar os dados", view: self)
        }
    }
    
    func maiorGlicemia(){
        
        if maxGlicemia > 0 {
            
            let glicemia:Glicemia = usuario.glicemias.sorted(by: {$0.valorGlicemico > $1.valorGlicemico}).first!
            
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
            
            goDetalheGlicemia(detalhe: detalhes)
        } else {
            mensagem.alertaSucesso(titulo: "Atenção", mensagem: "Para realizar esta função necessita de 2 ou mais exames", view: self)
        }
    }
    
    func menorGlicemia(){
        if minGlicemia > 0 {
            
            let glicemia:Glicemia = usuario.glicemias.sorted(by: {$0.valorGlicemico < $1.valorGlicemico}).first!
            
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
            
            goDetalheGlicemia(detalhe: detalhes)
        } else {
            mensagem.alertaSucesso(titulo: "Atenção", mensagem: "Para realizar esta função necessita de 2 ou mais exames", view: self)
        }
    }
    
    func goGrafico(){
        self.performSegue(withIdentifier: "goGrafico", sender: nil)
    }
    
    func goRealizarExames(){
        self.performSegue(withIdentifier: "goRealizarExame", sender: nil)
    }
    
    func goConsultar(){
        self.performSegue(withIdentifier: "goConsultar", sender: nil)
    }
    
    func goConfiguracao(){
        self.performSegue(withIdentifier: "goConfiguracao", sender: nil)
    }
    
    func goDetalheGlicemia(detalhe: DeatalheGlicemia){
        let vcDetalhes = DetalheExameViewController(detalhesGlicemico: detalhe)
        navigationController?.pushViewController(vcDetalhes, animated: true)
    }
}
