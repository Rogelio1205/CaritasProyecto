//
//  InfoDonantesTop.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 05/10/26.
//

import Foundation

struct InfoDonantesTop: Codable, Identifiable {
    let id: Int
    let nombreDonante: String
    let apellidoDonante: String
    let totalDonado: Float
    let numDonaciones: Int
    let promedioDonado: Float
}
