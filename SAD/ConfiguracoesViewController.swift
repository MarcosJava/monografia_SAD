//
//  ConfiguracoesViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 12/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class ConfiguracoesViewController: UIViewController {
    
    @IBOutlet weak var dataNascimentoField: UITextField!
    @IBOutlet weak var qtdMaximaField: UITextField!
    @IBOutlet weak var qtdMinimaField: UITextField!
    var usuario:Usuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usuario = Usuario()
        self.hideKeyboardWhenTappedAround()
        populaCampo()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(ConfiguracoesViewController.salvar))
        
    }
    
    func populaCampo() {
        
        let idConfiguracao = verificaUsuarioTemConfiguracao()
        
        if( idConfiguracao != 0 ){
            
            let realm = try! Realm()
            let configuracao = Configuracao()
            configuracao.id = idConfiguracao
            configuracao.configuracaoComId(realm: realm)
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            
            self.dataNascimentoField.text = dateFormat.string(from: configuracao.dtNascimento!)
            self.qtdMaximaField.text = String.init(format: "%f", configuracao.maiorGlicemia)
            self.qtdMinimaField.text  = String(configuracao.menorGlicemia)
            
            print(configuracao)
            
        }
    }
    
    func verificaUsuarioTemConfiguracao() -> Int{
        let realm = try! Realm()
        _ = self.usuario.hasUsuarioLogado(realm: realm)
        
        if ( self.usuario.configuracao > 0 ){
            return self.usuario.configuracao
            
        } else {
            return 0;
        }
    }
    
    func salvar(){
        
        if let dtNascimento = self.dataNascimentoField.text,
            let qtdMaxima = self.qtdMaximaField.text,
            let qtdMinima = self.qtdMinimaField.text {
            
            if dtNascimento != "" && qtdMaxima != "" && qtdMinima != "" {
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    realm.cancelWrite()
                    
                    let configuracao = Configuracao()
                    configuracao.menorGlicemia = Double(qtdMinima)!
                    configuracao.maiorGlicemia = Double(qtdMaxima)!
                    
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "dd/MM/yyyy"
                    
                    configuracao.dtNascimento = dateFormat.date(from: dtNascimento)
                    configuracao.save(realm: realm)
                    
                    let usuario = Usuario()
                    _ = usuario.hasUsuarioLogado(realm: realm)
                    usuario.configuracao = configuracao.id
                    usuario.update(realm: realm)
                    
                } catch _ as NSError {
                    print("DEU ERRO")
                }
            }
            
        }
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
