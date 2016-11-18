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
    dynamic var dtNascimento:Date? = nil
    dynamic var menorGlicemia:Double = 0.0
    dynamic var maiorGlicemia:Double = 0.0
    dynamic var tipoPressao:String = ""
    dynamic var ativo:Int = 1
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


// FUNCTIONS PERSISTENCIAS
extension Configuracao {
    
    func save(realm: Realm) {
        do{
            print("========================== " + realm.configuration.fileURL!.absoluteString)
            self.id = pegaUltimoId(realm: realm) + 1
            try realm.write {
                realm.add(self)
            }
        }catch _ as NSError {
            print("Error ao inserir configuracaos")
        }
    }
    

    func pegaUltimoId(realm: Realm) -> Int {
        
        do {
            print("======================= " + realm.configuration.fileURL!.absoluteString)
            let configuracao = realm.objects(Configuracao.self).filter("id > 0").sorted(byProperty: "id", ascending: false)
            
            if configuracao.count > 0 {
                return (configuracao.first?.id)!
            } else {
                return 1
            }
            
        } catch let error as NSError {
            print(error)
            return 1
        }
        
    }
    
    func configuracaoComId(realm: Realm) {
        do {
            print("======================= " + realm.configuration.fileURL!.absoluteString)
            let configuracao = realm.objects(Configuracao.self).filter("id == %@", self.id).first
            
            if configuracao != nil && configuracao?.id != nil {
                self.id = (configuracao?.id)!
                self.ativo = (configuracao?.ativo)!
                self.dtNascimento = configuracao?.dtNascimento
                self.maiorGlicemia = (configuracao?.maiorGlicemia)!
                self.menorGlicemia = (configuracao?.menorGlicemia)!
            }
            
        } catch let error as NSError {
            print(error)
        }
        
    }
}
