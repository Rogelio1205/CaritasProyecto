//
//  DonanteRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import Foundation

struct DonanteRiesgo: Codable, Identifiable {
    let idDonante: Int
    let nombre: String
    let mesesUltimaDonacion: Int
    let nivel: String                       
    var id: Int { idDonante }

    enum CodingKeys: String, CodingKey {
        case idDonante, nombre, nivel
        case mesesUltimaDonacion = "mesesSinDonar"
    }
}
