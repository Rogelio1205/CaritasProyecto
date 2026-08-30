//
//  PromesaPago.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import Foundation

struct PromesaPago: Identifiable, Hashable {
    let id = UUID()

    let campaña: String
    let frecuenciaTexto: String
    let cantidad: Double
    let idPromesa: Int
    let frecuencia: String
    let tipoFrecuencia: String
    let formaPago: String
    let asignacion: String
    let categoria: String
    let numeroCaso: String
    let lineaEstrategica: String
    let fechaAlta: String
    let fechaCancelacion: String
    let motivoCancelacion: String
}
