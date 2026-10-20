//
//  RecoleccionesHoy.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import Foundation

struct RecoleccionesHoy : Identifiable, Codable {
    let id = UUID()
    let Completadas: Int
    let Pendientes: Int
    let parciales: Int
    let programadasHoy: Int
    
    enum CodingKeys: String, CodingKey {
            case Completadas, Pendientes, parciales, programadasHoy
        }
}
