//
//  DashboardViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GraphRequest(graphPath: "me", parameters: ["fields":"email,name,picture"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            
            switch result {
            case .success(let value):
                print("Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                print(value.dictionaryValue)
                print("Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
            case .failed(let error):
                print(error)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
