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
        adicionarBtnAtivado(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func adicionarBtnAtivado(_ resultado: Bool){
        
        self.adicionarBtn.isEnabled = resultado
        if resultado {
            self.adicionarBtn.layer.opacity = 1
        } else {
            self.adicionarBtn.layer.opacity = 0.5
        }
    }
    
    private func carregaDados() {
        let realm = try! Realm()
        realm.beginWrite()
        _ = usuario.hasUsuarioLogado(realm: realm)
        self.configuracao.id = usuario.configuracao
        self.configuracao.configuracaoComId(realm: realm)
        try! realm.commitWrite()
        
        print(self.usuario)
        print(self.configuracao)
    }
    
    private func observacoesShow(_ resultado: Bool){
        self.observacaoField.isHidden = !resultado
        self.observacaoLabel.isHidden = !resultado
    }

    
    @IBAction func glicemiaChangeAction(_ sender: Any) {
        
        guard let glicemia = Double(self.glicemiaField.text!) else {return}
        
        if configuracao.maiorGlicemia > glicemia || glicemia > configuracao.menorGlicemia {
            observacoesShow(false)
        } else {
            observacoesShow(true)
        }
        
        if glicemia > 1 {
            adicionarBtnAtivado(true)
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
        
        self.glicemia.configuracao = self.configuracao.id
        self.glicemia.taxaHormonal = txHormonal
        self.glicemia.valorGlicemico = glicemia
        self.glicemia.pressaoMaior = pressaoMax
        self.glicemia.pressaoMenor = pressaoMin
        self.glicemia.observacao = observacao
        
        self.glicemia.save(usuario: self.usuario)
        
        let mensagem = MensagensUtil()
        mensagem.alertaSucesso(titulo: "SALVO", mensagem: "Exame salvo com sucesso", view: self)
        
        resetFormularios()
        
    }
    
    func resetFormularios(){
        self.glicemiaField.text = ""
        self.pressaoMinimaField.text = ""
        self.pressaoMaximaField.text = ""
        self.taxaHormonalField.text = ""
        self.observacaoField.text = ""
        self.glicemia = Glicemia()
        
        observacoesShow(false)
        adicionarBtnAtivado(false)
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
