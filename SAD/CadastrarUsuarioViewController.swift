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
    var usuarioDTO = UsuarioDTO()
    var usuarioDAO = UsuarioManager()
    var count = 0
    
    
    let EMAIL = "Inserir seu e-mail"
    let SENHA = "Inserir uma senha"
    let CONFIRMACAO_SENHA = "Confirme a senha anterior"
    let PARABENS = "Parabens por realizar nosso cadastro."

    @IBOutlet weak var txtInformativo: UILabel!
    @IBOutlet weak var txtResposta: UITextField!
    @IBOutlet weak var lbError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEmailView()
        super.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func voltar(_ sender: Any) {
        goPrincipal()
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
                goPrincipal()
                salvarUsuario()
            }
        }
        
    }
    
    func salvarUsuario(){
        usuarioDAO.salvarUsuario(usuarioDTO: usuarioDTO)
        usuarioDAO.listaTodos()
    }
    
    
    func goPrincipal() -> Void {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
    
       
    func showErro(msg: String ){
        
        self.lbError.alpha = 0
        self.lbError.isHidden = false
        self.lbError.text = msg
        
        UIView.animate(withDuration: 1, animations: {
            self.lbError.alpha = 1
        }) { (finished) in
            
            UIView.animate(withDuration: 7) {
                self.lbError.alpha = 0
            }
        }
        
    }
    
}



//VALIDACOES --
extension CadastrarUsuarioViewController {
    
    func validaEmail(){
        let emailCorreto = Validador().emailValido(email: txtResposta.text!)
        
        if(emailCorreto) {
            usuarioDTO.email = self.txtResposta.text!
            setSenhaView();
            
        } else {
            showErro(msg: "Email esta fora do padrão")
            
        }
    }
    
    func validaSenha(){
        
        if txtResposta.text != nil {
            self.usuarioDTO.senha = txtResposta.text!
            if self.usuarioDTO.senha.characters.count > 4 {
                setConfirmaSenhaView()
            }else {
                showErro(msg: "Senha deve ter mais que 4 digitos")
            }
            
        }
    }
    
    func validaConfirmaSenha(){
        let senha = self.usuarioDTO.senha
        
        if(senha.caseInsensitiveCompare(txtResposta.text!) == ComparisonResult.orderedSame){
            setParabensView()
            
        } else {
            count += 1
            showErro(msg: "Senha deve ser igual a anterior.")
            if (count == 3){
                setSenhaView()
            }
            
        }
    }

}







//View e Cores
extension CadastrarUsuarioViewController {
    
    func setEmailView(){
        self.view.backgroundColor = colors.getCyan()
        txtInformativo.text = EMAIL
        txtResposta.text = ""
        txtResposta.placeholder = "saude@cuide.com"
        txtResposta.isSecureTextEntry = false
        txtResposta.keyboardType = UIKeyboardType.emailAddress
        lbError.isHidden = true
        
    }
    
    func setSenhaView(){
        count = 0
        self.view.backgroundColor = colors.getCyan()
        txtInformativo.text = SENHA
        txtResposta.text = ""
        txtResposta.placeholder = "senha123"
        txtResposta.isSecureTextEntry = true
        txtResposta.keyboardType = UIKeyboardType.default
        lbError.isHidden = true
        self.usuarioDTO.senha = ""
    }
    
    func setConfirmaSenhaView() {
        self.view.backgroundColor = colors.getLightGreen()
        txtInformativo.text = CONFIRMACAO_SENHA
        txtResposta.text = ""
        txtResposta.placeholder = "123"
        txtResposta.isSecureTextEntry = true
        txtResposta.keyboardType = UIKeyboardType.default
        lbError.isHidden = true
    }
    
    func setParabensView() {
        self.view.backgroundColor = colors.getBluePrincipal()
        txtInformativo.text = PARABENS
        txtResposta.isHidden = true
        lbError.isHidden = true
        
    }
    
}
