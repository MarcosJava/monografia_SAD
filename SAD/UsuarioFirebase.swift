//
//  UsuarioFirebase.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import Marshal

struct UsuarioFirebase: Unmarshaling {
    
    var id:Int
    var email:String
    var senha:String
    var logado:Bool
    var configuracao:Int = 0
    var glicemias = Array<GlicemiaFirebase>()
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        email = try object.value(for: "email")
        senha = try object.value(for: "senha")
        logado = try object.value(for: "logado")
        configuracao = try object.value(for: "configuracao")
    }
    
    init(id: Int, email: String, senha: String, logado:Bool, configuracao:Int) {
        self.id = id
        self.email = email
        self.senha = senha
        self.logado = logado
        self.configuracao = configuracao
    }
    
}

extension UsuarioFirebase: Marshaling {
    
    func marshaled() -> [String: Any] {
        return {[
            "id": self.id,
             "email": self.email,
             "senha": self.senha,
             "logado": self.logado,
             "configuracao": self.configuracao,
             "glicemias": self.glicemias]
            }()
    }
}
    
