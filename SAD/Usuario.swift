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
    let glicemias:List<Glicemia>? = nil
    let configuracoes:List<Configuracao>? = nil

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}



/***
 
    CONSULTAS
 
 ***/
extension Usuario {

    func save() {
        do {
            let realm = try Realm()
            print("========================== " + realm.configuration.fileURL!.absoluteString)
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func update(){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Usuario.self, value: ["id": self.id, "logado": self.logado, "email": self.email, "senha": self.senha], update: true)
        }
        
    }
    
    func pegaUltimoId() -> Int {
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            print("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
            let usuarios = realm.objects(Usuario.self).filter("id > 0").sorted(byProperty: "id")
            
            if usuarios.count > 0 {
                return (usuarios.first?.id)!
            } else {
                return 0
            }
            
        } catch let error as NSError {
            print(error)
            return 0
        }
        
    }
    
    func putUsuarioLogado(){
        do {
            self.logado = true
            update()
        }
    }
    
    func contemUsuario(email: String, senha: String) -> Bool {
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            print("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
            
            let usuarios = realm.objects(Usuario.self).filter("email = '\(email)' AND senha='\(senha)'")
            
            if usuarios.count > 0 {
                self.id = (usuarios.first?.id)!
                self.email = (usuarios.first?.email)!
                self.senha = (usuarios.first?.senha)!
                return true
            } else {
                return false
            }
            
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    func hasUsuarioLogado() -> Bool {
        
        do {
            let realm = try Realm()
            let usuarios = realm.objects(Usuario.self).filter("logado = true")
            
            if let usuario = usuarios.first {
                self.id = usuario.id
                self.email = usuario.email
                self.logado = usuario.logado
                self.senha = usuario.senha
                
                
                return true
            } else {
                return false
            }
            
        }catch let error as NSError{
            print(error)
            return false
        }
        
        return false
    }
    
    
    
}
