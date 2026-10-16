//
//  CasosActivos.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 05/10/26.
//

import Foundation

struct CasosActivosMain : Identifiable, Codable {
    let id = UUID()
    let nombreCampaña: String
    let descripcion: String
    let recaudado: Int
    let meta: Int
    
    enum CodingKeys: String, CodingKey {
            case nombreCampaña, descripcion, recaudado, meta
        }
}
