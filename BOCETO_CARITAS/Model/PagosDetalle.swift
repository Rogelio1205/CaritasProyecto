//
//  PagosDetalle.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 23/09/26.
//

import Foundation

struct PagoDetalle: Codable, Identifiable {
    let idPago: Int
    let nombreCampana: String
    let estatusPago: String
    let formaPago: String
    let fechaConfirmacion: String?
    let cancelado: String
    let reprogramado: String
    let fechaReprogramacion: String?
    let monto: String
    
    var montoDouble: Double {
        return Double(monto) ?? 0.0
    }
    
    var id: Int { idPago }
}
