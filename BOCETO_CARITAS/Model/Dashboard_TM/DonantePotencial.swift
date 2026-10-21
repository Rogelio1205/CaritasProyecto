//
//  DonantePotencial.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import Foundation

struct DonantePotencial: Codable, Identifiable {
    let idDonante: Int
    let nombre: String
    let mesesUltimaDonacion: Int
    let casosSimilares: Int
    var id: Int { idDonante }

    enum CodingKeys: String, CodingKey {
        case idDonante, nombre, casosSimilares
        case mesesUltimaDonacion = "mesesSinDonar"
    }
}
