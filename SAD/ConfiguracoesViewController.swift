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
    var idConfiguracao:Int = 0
    var usuario:Usuario!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usuario = Usuario()
        self.hideKeyboardWhenTappedAround()
        populaCampo()
        
        
        
    }
    func adicionaButtonNoNavegador(_ titulo: String){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: titulo, style: .done, target: self, action: #selector(ConfiguracoesViewController.salvar))
    }
    func populaCampo() {
        
        idConfiguracao = verificaUsuarioTemConfiguracao()
        
        if(idConfiguracao != 0 ){
            
            let realm = try! Realm()
            let configuracao = Configuracao()
            configuracao.id = idConfiguracao
            configuracao.configuracaoComId(realm: realm)
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            
            self.dataNascimentoField.text = dateFormat.string(from: configuracao.dtNascimento!)
            self.qtdMaximaField.text = String.init(format: "%f", configuracao.maiorGlicemia)
            self.qtdMinimaField.text  = String(configuracao.menorGlicemia)
            adicionaButtonNoNavegador("Alterar")
            print(configuracao)
            
        } else {
            adicionaButtonNoNavegador("Salvar")
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
                    
                    
                    let alert = MensagensUtil()
                    let titulo = idConfiguracao == 0 ? "SALVO" : "ALTERADO"
                    let mensagem = idConfiguracao == 0 ? "Configuração salva com sucesso" : "Configuração alterada com sucesso"
                    alert.alertaSucesso(titulo: titulo, mensagem: mensagem, view: self)

                    
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
    @IBAction func dtNascimentoFieldBeginEdit(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        self.dataNascimentoField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ConfiguracoesViewController.dtNascimentoValueChange), for: .valueChanged)
        
    }


    func dtNascimentoValueChange(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        dataNascimentoField.text = dateFormat.string(from: sender.date)
        
    }
    
}
