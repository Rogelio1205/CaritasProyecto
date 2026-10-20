//
//  RecoleccionesMes.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import Foundation

struct RecoleccionesMes : Identifiable, Codable {
    let id = UUID()
    let exitosas: Int
    let parciales: Int
    let reprogramadas: Int
    
    enum CodingKeys: String, CodingKey {
            case exitosas, parciales, reprogramadas
    }
}
