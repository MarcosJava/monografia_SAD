//
//  UsuarioDAO.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 02/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import RealmSwift

class UsuarioManager {
    
    
    
    func salvarUsuario(usuarioDTO: UsuarioDTO) -> UsuarioDTO {
        let usuario = Usuario()
        usuario.email = usuarioDTO.email
        usuario.senha = usuarioDTO.senha
        usuario.logado = usuarioDTO.logado
        usuario.id = 1
        usuario.save()
        
        return usuarioDTO
    }
    
    func listaTodos() -> Array<Usuario> {
        
        var usuarios = Array<Usuario>()
        
        do {
            let realm = try Realm() //try Realm(configuration: config)
            debugPrint("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
            usuarios = Array(realm.objects(Usuario.self).filter("id > 0"))
            print(usuarios[0].email)
            return usuarios
        
        } catch let error as NSError {
            print(error)
            return usuarios
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
