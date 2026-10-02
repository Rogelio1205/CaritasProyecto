//
//  RecoleccionesMes.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import Foundation

struct RecoleccionesMes : Identifiable, Codable {
    let id = UUID()
    let cantidad: Int
    let estado: String
}
