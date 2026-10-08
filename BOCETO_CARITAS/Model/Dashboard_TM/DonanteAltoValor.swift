//
//  DonanteAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import Foundation

struct DonanteAltoValor: Codable, Identifiable {
    let idDonante: Int
    let nombre: String
    let mesesUltimaDonacion: Int
    let totalDonado: Double
    var id: Int { idDonante }

    enum CodingKeys: String, CodingKey {
        case idDonante, nombre, totalDonado
        case mesesUltimaDonacion = "mesesSinDonar"
    }
}
