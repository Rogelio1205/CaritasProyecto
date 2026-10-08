//
//  RecaudacionAreaService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import Foundation

private let urlBase = "http://10.14.255.41:10206/"

class RecaudacionAreaService {
    func getCasosActivos() async  throws -> [CasosActivos]{
        guard let url = URL(string: "\(urlBase)casosActivos") else {
            print("URL incorrecto")
            throw URLError(.badURL)
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Respuesta no valida del servidor")
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            print("Codigo de error del API: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let jsonDecoder = JSONDecoder()
        let casosActivos = try jsonDecoder.decode([CasosActivos].self, from: data)
        
        return casosActivos
    }
    
    func getRecaudado() async  throws -> [RecaudadoArea]{
        guard let url = URL(string: "\(urlBase)graficasInfo") else {
            print("URL incorrecto")
            throw URLError(.badURL)
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Respuesta no valida del servidor")
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            print("Codigo de error del API: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let jsonDecoder = JSONDecoder()
        let recaudado = try jsonDecoder.decode([RecaudadoArea].self, from: data)
        
        return recaudado
    }
    
    func getWidgets() async  throws -> Widgets {
        guard let url = URL(string: "\(urlBase)widgets") else {
            print("URL incorrecto")
            throw URLError(.badURL)
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Respuesta no valida del servidor")
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            print("Codigo de error del API: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let jsonDecoder = JSONDecoder()
        let areasActivas = try jsonDecoder.decode(Widgets.self, from: data)
        
        return areasActivas 
    }
}

