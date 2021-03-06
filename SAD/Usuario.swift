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
    dynamic var id = 0
    dynamic var email = ""
    dynamic var senha = ""
    dynamic var logado = false
    var glicemias = List<Glicemia>()
    dynamic var configuracao:Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}

/***
 
    CONSULTAS REALM
 
 ***/
extension Usuario {

    func save() {
        do {
            let realm = try Realm()
            print("========================== " + realm.configuration.fileURL!.absoluteString)
            self.id = pegaUltimoId() + 1
            
            try realm.write {
                realm.add(self)
            }
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func update(realm: Realm){
        
        try! realm.write {
            realm.create(Usuario.self, value: ["id": self.id,
                                               "logado": self.logado,
                                               "email": self.email,
                                               "senha": self.senha,
                                               "configuracao":self.configuracao,
                                               "glicemias":self.glicemias], update: true)
        }
        
    }
    
    func pegaUltimoId() -> Int {
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            print("======================= " + realm.configuration.fileURL!.absoluteString)
            
            let usuarios = realm.objects(Usuario.self).filter("id > 0").sorted(byProperty: "id", ascending: false)
            
            for u in usuarios {
                print(u.id)
            }
            
            if usuarios.count > 0 {
                let usuario = usuarios.first
                let id = usuario?.id
                return id!
            } else {
                return 0
            }
            
        } catch let error as NSError {
            print(error)
            return 0
        }
        
    }
    
    func putUsuarioLogado(realm: Realm){
        do {
            self.logado = true
            update(realm: realm)
        }
    }
    
    func deleteTudo(_ realm: Realm){
        try! realm.write {
            realm.deleteAll()
        }
    }

    func contemUsuario(_ email: String, senha: String) -> Bool {
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            print("=======================: " + realm.configuration.fileURL!.absoluteString)
            
            let usuarios = realm.objects(Usuario.self).filter("email = '\(email)' AND senha='\(senha)'")
            
            guard let usuario = usuarios.first  else { return false}
            
            self.id = usuario.id
            self.email = usuario.email
            self.senha = usuario.senha
            self.glicemias  = usuario.glicemias
            self.configuracao = usuario.configuracao
            return true
            
            
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    func usuarioCom(email: String) -> Usuario? {
        
        do {
            
            let realm = try Realm()
            let predicate = NSPredicate(format: "email == %@", argumentArray: [email])
            let usuarios = realm.objects(Usuario.self).filter(predicate)
            
            if usuarios.first != nil {
                return usuarios.first!
            }
            return nil
        } catch let error as NSError {
            fatalError("Erro ao descobrir se contem o usuario com o email \(error.localizedDescription)")
        }
        
    }
    
    
    func carregaConfiguracao(realm: Realm) {
        let predicate = "id=\(self.id) configuracao.id != 0"
        
        let usuarios = realm.objects(Usuario.self).filter(predicate)
        
        if let usuario = usuarios.first {
            self.id = usuario.id
            self.email = usuario.email
            self.logado = usuario.logado
            self.senha = usuario.senha
            self.configuracao = usuario.configuracao
            self.glicemias = usuario.glicemias
        }
    }
    
    func hasUsuarioLogado(realm: Realm) -> Bool {
        let usuarios = realm.objects(Usuario.self).filter("logado = true")
        
        if let usuario = usuarios.first {
            self.id = usuario.id
            self.email = usuario.email
            self.logado = usuario.logado
            self.senha = usuario.senha
            self.configuracao = usuario.configuracao
            self.glicemias = usuario.glicemias
            
            return true
        } else {
            return false
        }
    }
    
}
