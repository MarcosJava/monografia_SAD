//
//  Usuario.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 03/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import RealmSwift

class Usuario: Object {
    dynamic var id = 1
    dynamic var email = ""
    dynamic var senha = ""
    dynamic var logado = false

    
//    override static func ignoredProperties() -> [String] {
//        return ["id"]
//    }
//    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    
}
