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
    var arrayMenu:Array = ["Realizar Exame", "Consultar", "Grafico", "Maior Glicemia", "Menor Glicemia", "Configuração"]
    var usuario:Usuario! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.usuario = Usuario()
        let realm = try! Realm()

        _ = usuario.hasUsuarioLogado(realm: realm)
        print(usuario)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.usuario = Usuario()
        let realm = try! Realm()
        
        _ = usuario.hasUsuarioLogado(realm: realm)
        print(usuario)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        if indexPath.row == 0 && usuario.configuracao == 0{
            cell.textLabel?.isEnabled = false
        }
        
        cell.textLabel?.text = arrayMenu[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir Next", size:15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(self.usuario != nil) {
            
            switch indexPath.row {
            case 0:
                print("REALIZAR EXAMES")
                if self.usuario.configuracao != 0 {
                    self.goRealizarExames()
                } else {
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }
                
                
            case 1:
                print("CONSULTAR")
                goConsultar()
            case 2:
                print("GRAFICO")
                
            case 3:
                print("MAIOR")
                
            case 4:
                print("MENOR")
                
            case 5:
                print("CONFIGS")
                goConfiguracao()
                
            default:
                print("DEU ERRU")
                self.tableView.deselectRow(at: indexPath, animated: true)
            }

        } else {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
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
}
