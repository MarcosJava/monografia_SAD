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
    dynamic var dtCadastro = NSDate()
    dynamic var observacao:String = ""
    dynamic var excluido:Bool = false
    dynamic var valorGlicemico:Double = 0.0
    dynamic var taxaHormonal:Double = 0.0
    dynamic var pressaoMenor:Double = 0.0
    dynamic var pressaoMaior:Double = 0.0
    dynamic var configuracao:Int = 0
    dynamic var sincronizado:Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}




extension Glicemia {
    func pegaUltimoId() -> Int {
        do {
            let realm = try Realm()
            print("======================= " + realm.configuration.fileURL!.absoluteString)
            guard let glicemia = realm.objects(Glicemia.self).filter("id > 0").sorted(byProperty: "id", ascending: false).first else { return 1}
            self.id = glicemia.id
            return glicemia.id
        } catch let error as NSError {
            print(error)
            return 0
        }
    }
    
    
    func save(usuario: Usuario) {
        do {
            let realm = try Realm()
            print("========================== " + realm.configuration.fileURL!.absoluteString)
            self.id = pegaUltimoId() + 1
            
            try realm.write {
                realm.add(self)
                usuario.glicemias.append(self)
                realm.add(usuario, update: true)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    
}
