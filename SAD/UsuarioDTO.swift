//
//  UsuarioDTO.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 02/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation

struct UsuarioDTO {
    var id:Int
    var email:String
    var senha:String
    var logado:Bool
    
    init() {
        id = 0
        email = ""
        senha = ""
        logado = true
    }
    
    init(with usuario: Usuario){
        
        self.id = usuario.id
        self.email = usuario.email
        self.senha = usuario.senha
        self.logado = usuario.logado
    }
    
    func parserToEntity() -> Usuario {
        
        let usuario = Usuario()
        
        usuario.id = self.id
        usuario.email = self.email
        usuario.senha = self.senha
        usuario.logado = self.logado

        return usuario
    }
    
    
}
