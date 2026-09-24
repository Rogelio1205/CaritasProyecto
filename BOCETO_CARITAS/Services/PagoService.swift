//
//  PagoService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 23/09/26.
//

import Foundation

private let baseURL = "http://10.14.255.41:10206"

func obtenerPagoDetalle(idPago: Int) async throws -> PagoDetalle {
    guard let url = URL(string: "\(baseURL)/pago/\(idPago)") else {
        print("URL incorrecto")
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else {
        print("Respuesta no válida del servidor")
        throw URLError(.badServerResponse)
    }
    
    guard httpResponse.statusCode == 200 else {
        print("Código de error del API: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    
    let jsonDecoder = JSONDecoder()
    let pago = try jsonDecoder.decode(PagoDetalle.self, from: data)
    
    return pago
}
