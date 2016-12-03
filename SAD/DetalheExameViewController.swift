//
//  DetalheExameViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 03/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit

class DetalheExameViewController: UIViewController {

    
    
    @IBOutlet weak var glicemiaLabel: UILabel!
    @IBOutlet weak var taxaHormonalLabel: UILabel!
    @IBOutlet weak var pressaoLabel: UILabel!
    @IBOutlet weak var dataExameLabel: UILabel!
    @IBOutlet weak var observacaoLabel: UITextView!
    
    @IBOutlet weak var dtMinGlicemia: UILabel!
    
    @IBOutlet weak var dtMaxGlicemia: UILabel!
    
    var detalhes:DeatalheGlicemia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(detalhesGlicemico: DeatalheGlicemia){
        super.init(nibName: "DetalheExameViewController", bundle: nil)
        detalhes = detalhesGlicemico
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        completeCampos()
    }
    
    func completeCampos(){
        
        guard let detalhe = detalhes else {
            if (navigationController != nil) {
                navigationController!.popViewController(animated: true)
            }
            return;
        }
        
        glicemiaLabel.text = detalhe.glicemia
        taxaHormonalLabel.text = detalhe.taxaHormonal
        dataExameLabel.text = detalhe.dtExame
        pressaoLabel.text = detalhe.pressao
        observacaoLabel.text = detalhe.observacao
        dtMaxGlicemia.text = detalhe.maiorGlicemia
        dtMinGlicemia.text = detalhe.menorGlicemia
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
