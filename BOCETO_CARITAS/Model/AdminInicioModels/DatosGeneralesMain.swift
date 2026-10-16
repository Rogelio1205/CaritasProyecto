//
//  DatosGeneralesMain.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 15/10/26.
//

import Foundation

struct DatosGeneralesMain : Identifiable, Codable {
    var id = UUID()
    var llamadasHoy: Int
    var porcentajeRecolecciones: Int
    var promesasHoy: Int
    var top10Donantes: Int
    
    enum CodingKeys: String, CodingKey {
        case llamadasHoy, porcentajeRecolecciones, promesasHoy, top10Donantes
    }
}
