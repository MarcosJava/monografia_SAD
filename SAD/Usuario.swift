//
//  Usuario.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 19/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import Marshal

public struct Usuario {
    
    let email: String
    let nome: String
    let urlFoto: String?
    
    //import Mapper

//    init(map: Mapper) throws {
//        try email = map.from("email")
//        try nome = map.from("name")
//        urlFoto = map.optionalFrom("url")
//    }
    
}

extension Usuario: Unmarshaling {
   
    public init(object json:MarshaledObject) throws {
        email = try! json.value(for: "email")
        nome = try! json.value(for: "name")
        urlFoto = try json.value(for: "picture.data.url")
    }
}
