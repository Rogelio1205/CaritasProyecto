//
//  MontosDelMes.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 15/10/26.
//

import Foundation

struct MontosDelMes : Identifiable, Codable {
    var id = UUID()
    var montoPrevisto: Int
    var montoRecaudado: Int
    
    enum CodingKeys: String, CodingKey {
        case montoPrevisto, montoRecaudado
    }
}
