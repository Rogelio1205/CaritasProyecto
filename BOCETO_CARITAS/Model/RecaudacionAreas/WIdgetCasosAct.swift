//
//  WIdgetCasosAct.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 06/10/26.
//

import Foundation


struct Widgets: Codable {
    var id: Int {
        return areasActivas
    }
    let areasActivas: Int
    let porRecaudar: Float
    let totalRecaudado: Float
}
