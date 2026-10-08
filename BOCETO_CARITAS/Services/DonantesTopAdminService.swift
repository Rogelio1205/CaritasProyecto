//
//  DonantesTopAdminService.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 08/10/26.
//

import Foundation

private let urlBase = "https://10.14.255.41:10206/"

class DonantesTopAdminService {
    func getInfoRows() async  throws -> [InfoDonantesTop]{
        guard let url = URL(string: "\(urlBase)donantesTopRow") else {
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
        let infoRowDonantesTop = try jsonDecoder.decode([InfoDonantesTop].self, from: data)
        
        return infoRowDonantesTop
    }
    
    func getPromedioDonanteGraph() async  throws -> MontoPromedioGraphs{
        guard let url = URL(string: "\(urlBase)promedioDonantes") else {
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
        let promedioInfo = try jsonDecoder.decode(MontoPromedioGraphs.self, from: data)
        
        return promedioInfo
    }
    
    func getAportacionTotal() async  throws -> AportacionTotalGraph{
        guard let url = URL(string: "\(urlBase)aportacionesTotal") else {
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
        let aportacionInfo = try jsonDecoder.decode(AportacionTotalGraph.self, from: data)
        
        return aportacionInfo
    }
    
    func getWidgetsTop() async  throws -> WidgetsTopDiez{
        guard let url = URL(string: "\(urlBase)widgetsTop") else {
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
        let widgetsInfo = try jsonDecoder.decode(WidgetsTopDiez.self, from: data)
        
        return widgetsInfo
    }
    
    
}
