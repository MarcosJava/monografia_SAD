//
//  UsuarioDTO.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 02/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation

struct UsuarioDTO {
    var email:String
    var senha:String
    var logado:Bool
    
    init() {
        email = ""
        senha = ""
        logado = false
    }
}
