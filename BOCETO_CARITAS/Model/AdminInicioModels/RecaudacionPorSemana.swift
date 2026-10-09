//
//  RecaudacionPorSemana.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 05/10/26.
//

import Foundation

struct RecaudacionPorSemana : Identifiable, Codable {
    var id = UUID()
    var semana: Int
    var recaudacion: Int
    var recPrevista: Int
}
