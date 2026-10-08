//
//  DashboardScreen.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import Foundation

struct DashboardScreen: Codable {
    let meta: Meta
    let riesgo: Riesgo
    let donantesEnRiesgo: [DonanteRiesgo]
    let donantesPotenciales: [DonantePotencial]
    let donantesAltoValor: [DonanteAltoValor]
}
