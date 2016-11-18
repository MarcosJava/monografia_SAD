//
//  CadastrarUsuarioViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 01/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit

class CadastrarUsuarioViewController: UIViewController {
    
    var colors:Colors = Colors()
    var count = 0
    var usuario:Usuario!
    
    
    let EMAIL = "Inserir seu e-mail"
    let SENHA = "Inserir uma senha"
    let CONFIRMACAO_SENHA = "Confirme a senha anterior"
    let PARABENS = "Parabens por realizar nosso cadastro."

    @IBOutlet weak var txtInformativo: UILabel!
    @IBOutlet weak var txtResposta: UITextField!
    @IBOutlet weak var lbError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usuario = Usuario()
        setEmailView()
        super.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func voltar(_ sender: Any) {
        goInicial()
    }
    
    @IBAction func proximo(_ sender: Any) {
        
        
        if let valor = txtInformativo.text {
            
            if(valor.caseInsensitiveCompare(EMAIL) == ComparisonResult.orderedSame){
                validaEmail()
            
            } else if(valor.caseInsensitiveCompare(SENHA) == ComparisonResult.orderedSame){
                validaSenha()
        
            } else if(valor.caseInsensitiveCompare(CONFIRMACAO_SENHA) == ComparisonResult.orderedSame){
                validaConfirmaSenha()
                
            } else if(txtInformativo.text?.caseInsensitiveCompare(PARABENS) == ComparisonResult.orderedSame){
                goInicial()
                salvarUsuario()
            }
        }
        
    }
    
    func salvarUsuario(){
        usuario.logado = true
        usuario.save()
    }
       
    func showErro(_ msg: String ){
        
        self.lbError.alpha = 0
        self.lbError.isHidden = false
        self.lbError.text = msg
        
        self.lbError.fadeInFadeOut(1, secondTime: 7)
        
    }
    
}



//VALIDACOES --
extension CadastrarUsuarioViewController {
    
    func validaEmail(){
        let emailCorreto = Validador().emailValido(txtResposta.text!)
        
        if(emailCorreto) {
            usuario.email = self.txtResposta.text!
            setSenhaView();
            
        } else {
            showErro("Email esta fora do padrão")
            
        }
    }
    
    func validaSenha(){
        
        if txtResposta.text != nil {
            self.usuario.senha = txtResposta.text!
            if self.usuario.senha.characters.count > 4 {
                setConfirmaSenhaView()
            }else {
                showErro("Senha deve ter mais que 4 digitos")
            }
            
        }
    }
    
    func validaConfirmaSenha(){
        let senha = self.usuario.senha
        
        if(senha.caseInsensitiveCompare(txtResposta.text!) == ComparisonResult.orderedSame){
            setParabensView()
            
        } else {
            count += 1
            showErro("Senha deve ser igual a anterior.")
            if (count == 3){
                setSenhaView()
            }
            
        }
    }

}







//View e Cores
extension CadastrarUsuarioViewController {
    
    func setEmailView(){
        self.view.backgroundColor = self.colors.getCyan()
        txtInformativo.text = EMAIL
        txtResposta.text = ""
        txtResposta.placeholder = "saude@cuide.com"
        txtResposta.isSecureTextEntry = false
        txtResposta.keyboardType = UIKeyboardType.emailAddress
        lbError.isHidden = true
        
    }
    
    func setSenhaView(){
        count = 0
        self.view.backgroundColor = colors.getLightGreen()
        txtInformativo.text = SENHA
        txtResposta.text = ""
        txtResposta.placeholder = "senha123"
        txtResposta.isSecureTextEntry = true
        txtResposta.keyboardType = UIKeyboardType.default
        lbError.isHidden = true
        self.usuario.senha = ""
    }
    
    func setConfirmaSenhaView() {
        self.view.backgroundColor = colors.getCyan()
        txtInformativo.text = CONFIRMACAO_SENHA
        txtResposta.text = ""
        txtResposta.placeholder = "123"
        txtResposta.isSecureTextEntry = true
        txtResposta.keyboardType = UIKeyboardType.default
        lbError.isHidden = true
    }
    
    func setParabensView() {
        self.view.backgroundColor = Colors().getBluePrincipal()
        txtInformativo.text = PARABENS
        txtResposta.isHidden = true
        lbError.isHidden = true
        
    }
    
}
