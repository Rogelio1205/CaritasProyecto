//
//  Donante.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 03/09/26.
//

import Foundation

struct Donante: Identifiable {
    let id = UUID()
    let nombre: String
    let ultimaDonacion: String
    let riesgo: NivelRiesgo
}
