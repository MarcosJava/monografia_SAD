//
//  GlicemiaFirebase.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/11/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import Foundation
import Marshal

struct GlicemiaFirebase : Unmarshaling{
    
    var id:Int
    var dtCadastro:String
    var observacao:String
    var excluido:Bool
    var valorGlicemico:Double
    var taxaHormonal:Double
    var pressaoMenor:Double
    var pressaoMaior:Double
    var configuracao:Int
    var sincronizado:Bool
    
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        dtCadastro = try object.value(for: "dtCadastro")
        observacao = try object.value(for: "observacao")
        excluido = try object.value(for: "excluido")
        valorGlicemico = try object.value(for: "valorGlicemico")
        taxaHormonal = try object.value(for: "taxaHormonal")
        pressaoMenor = try object.value(for: "pressaoMenor")
        pressaoMaior = try object.value(for: "pressaoMaior")
        configuracao = try object.value(for: "configuracao")
        sincronizado = try object.value(for: "sincronizado")
    }
    

}
