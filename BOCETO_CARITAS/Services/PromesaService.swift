//
//  PromesaService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 21/09/26.
//

import Foundation

private let baseURL = "http://10.14.255.41:10206"

func ObtenerPromesaDetalle(idPromesa: Int) async throws -> PromesaDetalle {
    guard let url = URL(string: "\(baseURL)/promesa/\(idPromesa)") else {
        print("URL incorrecto")
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else{
        print("Respuesta no valida del servidor")
        throw URLError(.badServerResponse)
    }
    
    guard httpResponse.statusCode == 200 else {
        print("Codigo de error del API: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    
    let jsonDecoder = JSONDecoder()
    let promesaDetalleX: PromesaDetalle = try jsonDecoder.decode(PromesaDetalle.self, from: data)
    return promesaDetalleX
}

func obtenerListaEstados() async throws -> [EstadoPromesa] {
    guard let url = URL(string: "\(baseURL)/estados") else {
        print("URL incorrecto")
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else{
        print("Respuesta no valida del servidor")
        throw URLError(.badServerResponse)
    }
    
    guard httpResponse.statusCode == 200 else {
        print("Codigo de error del API: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }
    
    let jsonDecoder = JSONDecoder()
    let arregloEstados = try jsonDecoder.decode([EstadoPromesa].self, from: data)
    
    return arregloEstados
}
