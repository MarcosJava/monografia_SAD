//
//  MaximoGlicemiaViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 03/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class MaximoGlicemiaViewController: UIViewController {

    @IBOutlet weak var viewDetalhes: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func configureView(){
        
        let usuario = Usuario()
        let realm = try! Realm()
        _  = usuario.hasUsuarioLogado(realm: realm)
        
        
        //let glicemia:Glicemia =  usuario.glicemias.sorted(by: { $0.valorGlicemico > $1.valorGlicemico }).first!
       
        //let vcDetalhes = DetalheExameViewController()
        
        //viewDetalhes.inputViewController = vcDetalhes
        
  //      super.present(vcDetalhes, animated: true, completion: nil)

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
