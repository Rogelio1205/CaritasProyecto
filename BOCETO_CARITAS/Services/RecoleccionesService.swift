//
//  RecoleccionesService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 21/09/26.
//

import Foundation

class RecoleccionesService {
    private let urlBase = "http://10.14.255.41:10206/hello"
    
    func getListaRecoleccionesProx() async throws -> Array<RecoleccionSiguiente>{
        
        guard let url = URL(string: "\(urlBase)") else{
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
    
    
}
