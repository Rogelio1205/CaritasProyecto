//
//  DonantePotencialDetalle.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 13/10/26.
//

import Foundation

struct DonantesPotenciales: Codable, Identifiable {
    let cantidadDonaciones: Int
    let donacionPotencial: Double
    let idDonante: Int
    let nombre: String
    var id: Int { idDonante }
}
