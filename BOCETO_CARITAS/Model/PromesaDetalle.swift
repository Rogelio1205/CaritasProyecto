//
//  Promesa.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 21/09/26.
//

import Foundation

struct PromesaDetalle: Codable, Identifiable{
    let categorias: [String]
    let estadoNombre: String
    let fecha: String
    let formaPago: String
    let frecuencia: String
    let idCaso: Int
    let idDonante: Int
    let idEstado: Int
    let idPromesa: Int
    let idUsuario: Int
    let monto: Double
    let nombreCaso: String
    let tipoFrecuencia: String
    
    var id: Int { idPromesa }
    
    var fechaCorta: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss 'GMT'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: fecha){
            let formatterSalida = DateFormatter()
            formatterSalida.dateFormat = "dd/MM/yyyy"
            return formatterSalida.string(from: date)
        }
        return fecha
    }
}

struct EstadoPromesa: Codable, Identifiable{
    let idEstado: Int
    let nombre: String
    
    var id: Int {idEstado}
}
