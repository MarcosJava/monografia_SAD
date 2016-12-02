//
//  ConsultarDadosViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class ConsultarDadosViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var dtPrimeiraField: UITextField!
    @IBOutlet weak var dtSegundaField: UITextField!
    
    var glicemias = [Glicemia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        dtSegundaField.isEnabled = false
        
        hideKeyboardWhenTappedAround()
        
        configurarDados()
    }
    
    
    
    
    func configurarDados() -> Void {
        let usuario = Usuario()
        let realm = try? Realm()
        _ = usuario.hasUsuarioLogado(realm: realm!)
        glicemias = Array(usuario.glicemias)
        glicemias.sort(by: { $0.dtCadastro.compare($1.dtCadastro as Date) == .orderedDescending })
        
    }
    
    @IBAction func buscarEntreDatas(_ sender: Any) {
        
        guard let dtPrimeira = dtPrimeiraField.text, let dtSegunda = dtSegundaField.text else {
            
            //TODO: Alert view pra selecionar as duas datas.
            return;
        }
        
        if dtPrimeira != "" && dtSegunda != "" {
            
            let dateFormatt = DateFormatter()
            dateFormatt.dateFormat = "dd/MM/yyyy"
            
            let dtOne = dateFormatt.date(from: dtPrimeira)!
            let dtTwo = dateFormatt.date(from: dtSegunda)!
            
            glicemias = glicemias.filter({
                ($0.dtCadastro.compare(dtOne) == .orderedDescending) && ($0.dtCadastro.compare(dtTwo) == .orderedAscending)
                
            })
            
            print(glicemias)
            tableView.reloadData()
            
        }
    }
    
    @IBAction func dtPrimeiraPicker(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dtPrimeiraField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ConsultarDadosViewController.dtPrimeiraValueChange), for: .valueChanged)
    }
    
    func dtPrimeiraValueChange(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        dtPrimeiraField.text = dateFormat.string(from: sender.date)
        dtSegundaField.isEnabled = true
        
    }
    
    
    @IBAction func dtSegundaPicker(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dtSegundaField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ConsultarDadosViewController.dtSegundaValueChange), for: .valueChanged)
    }
    
    func dtSegundaValueChange(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        
        let datePrimeira = dateFormat.date(from: dtPrimeiraField.text!)
        
        if datePrimeira?.compare(sender.date) == .orderedAscending {
            dtSegundaField.text = dateFormat.string(from: sender.date)
        
        } else {
            dtSegundaField.text = dateFormat.string(from: sender.date)
            dtPrimeiraField.text = dateFormat.string(from: sender.date)
        }
        
    }
    
    var textoFormato: () -> (UIFont) = {
         UIFont(name: "Avenir Next", size:15)!
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


extension ConsultarDadosViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidAppear(_ animated: Bool) {
        if glicemias.count > 1 {
            let index = IndexPath(row: 1, section: 0)
            tableView.scrollToRow(at: index, at: .top, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glicemias.count
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "dd/MM/yyyy"
        
        if let glicemia:Glicemia = glicemias[indexPath.row] {
            cell.textLabel?.text = "Dados glicemicos: \(glicemia.valorGlicemico)"
            cell.detailTextLabel?.text = "data: \(dateFormatt.string(from: glicemia.dtCadastro as Date))"
            
            
            cell.textLabel?.font = textoFormato()
            
        }
        return cell
        
    }
    
    
}



