//
//  RecoleccionesHoy.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import Foundation

struct RecoleccionesHoy : Identifiable, Codable {
    let id = UUID()
    let cantidad: Int
    let estado: String
}
