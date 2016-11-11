//
//  Glicemia.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 09/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import RealmSwift

class Glicemia: Object {
    
    dynamic var id:Int = 0
    dynamic var configuracao:Configuracao?
    dynamic var dtCadastro = NSDate()
    dynamic var observacao:String = ""
    dynamic var excluido:Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
