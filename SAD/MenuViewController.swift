//
//  MenuViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var tableView: UITableView!
    var arrayMenu:Array = ["Realizar Exame", "Consultar", "Grafico", "Maior Glicemia", "Menor Glicemia", "Configuração"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        if indexPath.row == 0 {
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
        if self.arrayMenu[indexPath.row] == "Realizar Exame" {
            goRealizarExames()
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func goRealizarExames(){
        self.performSegue(withIdentifier: "goRealizarExame", sender: nil)
    }
    
}
