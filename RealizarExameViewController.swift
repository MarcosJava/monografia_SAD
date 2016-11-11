//
//  RealizarExameViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 08/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit

class RealizarExameViewController: UIViewController {

    @IBOutlet weak var txtExames: UITextField!
    @IBOutlet weak var lbObservacao: UILabel!
    @IBOutlet weak var txtObservacao: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
