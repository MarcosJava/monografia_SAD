//
//  RealizarExameViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 08/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class RealizarExameViewController: UIViewController {

    
    @IBOutlet weak var glicemiaField: UITextField!
    @IBOutlet weak var taxaHormonalField: UITextField!
    @IBOutlet weak var pressaoMinimaField: UITextField!
    @IBOutlet weak var pressaoMaximaField: UITextField!
    @IBOutlet weak var observacaoLabel: UILabel!
    @IBOutlet weak var observacaoField: UITextField!
    @IBOutlet weak var adicionarBtn: UIButton!
    
    var usuario = Usuario()
    var glicemia = Glicemia()
    var configuracao = Configuracao()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
        
        
        carregaDados()
        adicionarBtnDesativado()
        
        print(self.usuario)
        print(self.configuracao)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func adicionarBtnDesativado(){
        self.adicionarBtn.isEnabled = false
        self.adicionarBtn.layer.opacity = 0.5
    }
    
    private func adicionarBtnAtivado(){
        self.adicionarBtn.isEnabled = true
        self.adicionarBtn.layer.opacity = 1
    }
    
    private func carregaDados() {
        let realm = try! Realm()
        _ = usuario.hasUsuarioLogado(realm: realm)
        self.configuracao.id = usuario.configuracao
        self.configuracao.configuracaoComId(realm: realm)
        
        
    }
    
    private func showObservacoes(){
        self.observacaoField.isHidden = false
        self.observacaoLabel.isHidden = false
    }
    
    private func hideObservacoes(){
        self.observacaoField.isHidden = true
        self.observacaoLabel.isHidden = true
    }

    
    @IBAction func glicemiaChangeAction(_ sender: Any) {
        
        guard let glicemia = Double(self.glicemiaField.text!) else {return}
        
        print("A maior Glicemia : \(configuracao.maiorGlicemia)")
        print("A menor Glicemia : \(configuracao.menorGlicemia)")
        print("A Glicemia digitada : \(glicemia)")
        
        if configuracao.maiorGlicemia > glicemia || glicemia > configuracao.menorGlicemia {
            hideObservacoes()
            
        } else {
            showObservacoes()
            
        }
        
        if glicemia > 1 {
            adicionarBtnAtivado()
        }
        
        
    }
    
    
    @IBAction func adicionarBtnAction(_ sender: Any) {
        
        guard let glicemia = Double(glicemiaField.text!),
            let observacao = observacaoField.text else {
                return
        }
        
        let txHormonal = Double(taxaHormonalField.text!) ?? 0.0
        let pressaoMin = Double(pressaoMinimaField.text!) ?? 0.0
        let pressaoMax = Double(pressaoMaximaField.text!) ?? 0.0

        
        _ = self.glicemia.pegaUltimoId()
        self.glicemia.configuracao = self.configuracao.id
        self.glicemia.taxaHormonal = txHormonal
        self.glicemia.valorGlicemico = glicemia
        self.glicemia.pressaoMaior = pressaoMax
        self.glicemia.pressaoMenor = pressaoMin
        self.glicemia.observacao = observacao
        self.glicemia.save()
        
        self.usuario.glicemias.append(self.glicemia)
        
        let realm = try! Realm()
        self.usuario.update(realm: realm)
        
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
