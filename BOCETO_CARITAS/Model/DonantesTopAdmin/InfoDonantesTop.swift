//
//  InfoDonantesTop.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 05/10/26.
//

import Foundation

struct InfoDonantesTop: Codable, Identifiable {
    let id: Int
    let nombre: String
    let apellidoPaterno: String
    let totalDonado: Float
    let numDonaciones: Int
    let montoPromedio: Float
}
