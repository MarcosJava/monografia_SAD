//
//  Configuracao.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 08/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import RealmSwift

class Configuracao: Object {

    dynamic var id:Int = 0
    dynamic var dtNascimento:NSDate? = nil
    dynamic var menorGlicemia:Double = 0.0
    dynamic var maiorGlicemia:Double = 0.0
    dynamic var usuario: Usuario? // to-one relationships must be optional

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    
}
