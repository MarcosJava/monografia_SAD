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
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func pegaUltimoId() -> Int {
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            debugPrint("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
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
    
    func contemUsuario(email: String, senha: String) -> Bool {
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            debugPrint("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
            let usuarios = realm.objects(Usuario.self).filter("email = '\(email)' AND senha='\(senha)'")
            
            if usuarios.count > 0 {
                return true
            } else {
                return false
            }
            
        } catch let error as NSError {
            print(error)
            return false
        }
        
    }
    
    
    
}
