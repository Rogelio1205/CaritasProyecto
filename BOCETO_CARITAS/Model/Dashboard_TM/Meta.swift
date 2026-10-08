//
//  Meta.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import Foundation

struct Meta: Codable {
    let llamadasHoy: Int
    let metaDiaria: Int

    var progreso: Double {
        metaDiaria > 0 ? min(Double(llamadasHoy) / Double(metaDiaria), 1) : 0
    }
}
