//
//  RecoleccionesService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 21/09/26.
//

import Foundation

class RecoleccionesService {
    static func getListaRecoleccionesProx() async throws -> Array<RecoleccionSiguiente>{
        
        guard let url = URL(string: "http://10.14.255.41:10206/recolecciones") else{
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
        jsonDecoder.dateDecodingStrategy = .iso8601
          let arregloRecolecciones = try jsonDecoder.decode([RecoleccionSiguiente].self, from: data)
          for recoleccionX in arregloRecolecciones {
              print(recoleccionX)
          }
        return arregloRecolecciones
      }
    
    static func getListaRecoleccionesProxByMonto() async throws -> Array<RecoleccionSiguiente>{
        
        guard let url = URL(string: "http://10.14.255.41:10206/recoleccionesMonto") else{
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
          let arregloRecolecciones = try jsonDecoder.decode([RecoleccionSiguiente].self, from: data)
          for recoleccionX in arregloRecolecciones {
              print(recoleccionX)
          }
        return arregloRecolecciones
      }
    
    static func getNumRecSemanal() async throws -> Int{
        
        guard let url = URL(string: "http://10.14.255.41:10206/numRecolecciones") else{
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
        let numRecSem = try jsonDecoder.decode(Int.self, from: data)
        print(numRecSem)
        return numRecSem
      }
    
    static func getMontoSumRec() async throws -> Int{
        
        guard let url = URL(string: "http://10.14.255.41:10206/recoleccionesMontoSum") else{
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
        let montoSum = try jsonDecoder.decode(Int.self, from: data)
        print(montoSum)
        return montoSum
      }
}
