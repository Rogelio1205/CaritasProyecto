//
//  CasosActivos.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import Foundation

struct CasosActivos: Identifiable, Codable {
    var id: Int {
        return idCaso
    }
    let idCaso: Int
    let nombre: String
    let descripcion: String
    let totalPagado: Float
}
