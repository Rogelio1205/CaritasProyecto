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
    
    var confirmacionCorta: String {
        guard let fecha = fechaConfirmacion else { return "Pendiente" }
        return formatearFecha(fecha)
    }
    
    var reprogramacionCorta: String {
        guard let fecha = fechaReprogramacion else { return "N/A" }
        return formatearFecha(fecha)
    }
    
    private func formatearFecha(_ textoFecha: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss 'GMT'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: textoFecha) {
            let formatterSalida = DateFormatter()
            formatterSalida.dateFormat = "dd/MM/yyyy"
            return formatterSalida.string(from: date)
        }
        return textoFecha
    }
}
