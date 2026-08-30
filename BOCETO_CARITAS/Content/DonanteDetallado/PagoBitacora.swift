//
//  PagoBitacora.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import Foundation

struct PagoBitacora: Identifiable, Hashable {
    let id = UUID()

    let campaña: String
    let fechaRealizada: String
    let monto: Double
    let statusPago: String
    let formaPago: String
    let fechaConfirmacion: String
    let motivoReprogramacion: String
    let fechaReprogramacion: String
    let comentarios: String
}
