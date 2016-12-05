//
//  RecuperarSenhaViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 04/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import MessageUI

class RecuperarSenhaViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func recuperarSenha(_ sender: Any) {
        
        guard let mailComposeViewController = configuredMailComposeViewController() else {
            return
        }
        
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
        
    }
    
    @IBAction func voltarLogin(_ sender: Any) {
        goInicial()
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController? {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        guard let email = emailField.text else {
            showErrorSemEmail()
            return nil
        }
        
        let usuarioTemp = Usuario()
        guard let usuario = usuarioTemp.usuarioCom(email: email) else {return nil}
        
        print(usuario.description)
        if usuario.email == email {
            
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject("Sua password do Sistema de Apoio Diabetico")
            mailComposerVC.setMessageBody("Sua senha é : \(usuario.senha)", isHTML: false)
        }
        
        
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let mensagem = MensagensUtil()
        mensagem.alertaSucesso(titulo: "Não conseguiu enviar o email", mensagem: "Seu dispositivo não envia email. Checa a configuração do seu email e tente novamnte.", view: self)
    }
    
    func showErrorSemEmail() {
        let mensagem = MensagensUtil()
        mensagem.alertaSucesso(titulo: "Não conseguiu enviar o email", mensagem: "Digite um novo e-mail", view: self)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
