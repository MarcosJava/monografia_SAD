//
//  EscolherGraficoViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 06/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class EscolherGraficoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
    var enviarMes = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func mensalAction(_ sender: Any) {
        self.tableView.isHidden = false
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meses.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = meses[indexPath.row]
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(EscolherGraficoViewController.tapCell))
        cell.addGestureRecognizer(gesture)
        
        return cell
        
    }
    
    func tapCell(gesture: UIGestureRecognizer){
        
        if gesture.state == .ended {
            
            let locationTap = gesture.location(in: tableView)
            guard let locationIndex = tableView.indexPathForRow(at: locationTap) else {
                return
            }
            
            
            
            let usuario = Usuario()
            _ = usuario.hasUsuarioLogado(realm: try! Realm())
            
            let glicemias = usuario.glicemias.filter{
                let calendar = NSCalendar.current
                let mes = calendar.component(Calendar.Component.month, from: $0.dtCadastro as Date)
                return mes == (locationIndex.row + 1 )
            }
            
            if glicemias.isEmpty {
                
                let mensagem = MensagensUtil()
                mensagem.alertaSucesso(titulo: "Atenção", mensagem: "Não contem glicemia nesse mês", view: self)
            } else {
                enviarMes = locationIndex.row + 1
                goMensal()
            }
            
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goMensal" {
            let nextScene = segue.destination as? GraficoMensalViewController
            nextScene?.mes = enviarMes
            
        }
    }
    
    func goMensal(){
        self.performSegue(withIdentifier: "goMensal", sender: nil)
    }
    

}
