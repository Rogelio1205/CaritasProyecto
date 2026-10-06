//
//  CasosActivos.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 05/10/26.
//

import Foundation

struct CasosActivos : Identifiable, Codable {
    let id = UUID()
    let nombreCampaña: String
    let descripcion: String
    let recaudado: Int
    let meta: Int
}
