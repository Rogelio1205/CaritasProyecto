//
//  RecoleccionSiguiente.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 11/09/26.
//

import Foundation

struct RecoleccionSiguiente: Identifiable {
    let id = UUID()
    let nombreDonante: String
    var diasHastaSigDonacion: Int
    let cantDonacion: Int
}
