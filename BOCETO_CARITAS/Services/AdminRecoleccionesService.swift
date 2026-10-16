//
//  AdminRecoleccionesService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 14/10/26.
//

import Foundation

class AdminRecoleccionesService {
    static func getDatosRecoleccionesMes() async throws -> RecoleccionesMes{
        
        guard let url = URL(string: "https://equipo4.tc2007b.tec.mx:10207/adminRecDatos") else{
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
          let datosRecolecciones = try jsonDecoder.decode([RecoleccionesMes].self, from: data)
        guard let datos = datosRecolecciones.first else {
            throw URLError(.cannotParseResponse)
        }
        print(datos)
        return datos
      }
    
    static func getDatosRecoleccionesHoy() async throws -> Array<RecoleccionesHoy>{
        
        guard let url = URL(string: "https://equipo4.tc2007b.tec.mx:10207/RecHoyStatus") else{
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
          let arregloRecolecciones = try jsonDecoder.decode([RecoleccionesHoy].self, from: data)
          for recoleccionX in arregloRecolecciones {
              print(recoleccionX)
          }
        return arregloRecolecciones
      }
}
