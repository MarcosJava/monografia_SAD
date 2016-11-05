//
//  UsuarioDAO.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 02/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import RealmSwift

class UsuarioDAO: RealmAbstract {
    
    
    
    func salvarUsuario(usuarioDTO: UsuarioDTO) -> UsuarioDTO {
        let usuario = Usuario()
        usuario.email = usuarioDTO.email
        usuario.senha = usuarioDTO.senha
        usuario.logado = usuarioDTO.logado
        usuario.id = 1
        
        do {
            let realm = try! Realm()
            try! realm.write {
                realm.add(usuario)
            }

        } catch let error as NSError {
            print(error)
        }
        
        
        return usuarioDTO
    }
    
    func ultimoID() -> Void {
        
        do {
            let realm = try Realm()  //Realm(configuration: config)
            debugPrint("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
            let usuarios = realm.objects(Usuario.self).filter("id > 0") // retrieves all Dogs from the default Realm
            print(usuarios[0].email)
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    
}




//extension Usuario {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
//        return NSFetchRequest<Usuario>(entityName: "Usuario");
//    }
//    
//    @NSManaged public var email: String?
//    @NSManaged public var id: Int64
//    @NSManaged public var logado: Bool
//    @NSManaged public var senha: String?
//
//}
