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
    
    init(id: Int, dtCadastro:String, observacao:String, excluido:Bool, valorGlicemico:Double, pressaoMenor:Double, pressaoMaior:Double, configuracao:Int, sincronizado: Bool, taxaHormonal:Double){
        
        self.id = id
        self.observacao = observacao
        self.excluido = excluido
        self.valorGlicemico = valorGlicemico
        self.pressaoMaior = pressaoMaior
        self.pressaoMenor = pressaoMenor
        self.configuracao = configuracao
        self.sincronizado = sincronizado
        self.dtCadastro = dtCadastro
        self.taxaHormonal = taxaHormonal
    }

}

extension GlicemiaFirebase: Marshaling {
    
    func marshaled() -> [String: Any] {
        return {[
            "id": self.id,
            "observacao": self.observacao,
            "dtCadastro": self.dtCadastro,
            "excluido": self.excluido,
            "configuracao": self.configuracao,
            "valorGlicemico": self.valorGlicemico,
            "pressaoMaior": self.pressaoMaior,
            "pressaoMenor": self.pressaoMenor,
            "sincronizado": self.sincronizado,
            "taxaHormonal": self.taxaHormonal]
            }()
    }
}
