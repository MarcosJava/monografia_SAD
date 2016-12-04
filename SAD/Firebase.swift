//
//  Firebase.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 20/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import Firebase

class FirebaseConfig {
    
    var reference = FIRDatabase.database().reference()
    
    init() {
        
        print("AGORAAAA !!!")
        var usuario = UsuarioFirebase(id: 0, email: "mfelipesp@gmail.com", senha: "123", logado: true, configuracao: 1)
        
        let glicemia = GlicemiaFirebase(id: 1, dtCadastro: "10/12/2016", observacao: "comi muito", excluido: false, valorGlicemico: 23.3, pressaoMenor: 23, pressaoMaior: 12, configuracao: 1, sincronizado: false, taxaHormonal: 4332)
        
        usuario.glicemias.append(glicemia)
        
        print(usuario.marshaled())
//        
//        
//        reference.child("SAD").setValue(usuario)
        let array = [usuario.marshaled(), usuario.marshaled(), usuario.marshaled()]
        reference.child(usuario.id.description).setValue(array)
//
        reference.observe(.childAdded, with: { (snapshot) in
            
            print("THIS IS WHAT IS IN THE DATABASE \(snapshot)")
            print("children")
            
            guard let obj = snapshot.children.allObjects.first else {return}
            print(obj)
//            let usuario = obj as! UsuarioFirebase
//            
//            print("USUARIO !!!!! ")
//            print(usuario)
            
            
            
        })
        
    }
    
    
    
    
    
}
