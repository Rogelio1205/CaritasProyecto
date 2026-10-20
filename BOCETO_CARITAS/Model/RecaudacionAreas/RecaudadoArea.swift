//
//  RecaudadoArea.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import Foundation

struct RecaudadoArea: Identifiable, Codable {
    var id: Int {
        return idCaso
    }
    let idCaso: Int
    let nombre: String
    let totalPagado: Float
    let montoSolicitado: Float
}
