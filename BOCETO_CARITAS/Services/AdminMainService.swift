//
//  AdminMainService.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 15/10/26.
//

import Foundation

class AdminMainService {
    
    static func getMontosDelMes() async throws -> MontosDelMes{
        
        guard let url = URL(string: "https://equipo4.tc2007b.tec.mx:10207/adminMainMontosRecaudacion") else{
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
          let datosRecolecciones = try jsonDecoder.decode([MontosDelMes].self, from: data)
        guard let datos = datosRecolecciones.first else {
            throw URLError(.cannotParseResponse)
        }
        print(datos)
        return datos
      }
    
    static func getDatosWidgetsMain() async throws -> DatosGeneralesMain{
        
        guard let url = URL(string: "https://equipo4.tc2007b.tec.mx:10207/adminMainWidgets") else{
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
          let datosRecolecciones = try jsonDecoder.decode([DatosGeneralesMain].self, from: data)
        guard let datos = datosRecolecciones.first else {
            throw URLError(.cannotParseResponse)
        }
        print(datos)
        return datos
      }
    
    static func getListaCasosActMain() async throws -> Array<CasosActivosMain>{
        
        guard let url = URL(string: "https://equipo4.tc2007b.tec.mx:10207/adminMainCasosAct") else{
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
          let datosCasosActMain = try jsonDecoder.decode([CasosActivosMain].self, from: data)
        for datoX in datosCasosActMain {
            print(datoX)
        }
        return datosCasosActMain
      }
    
    static func getListaRecSemana() async throws -> Array<RecaudacionPorSemana>{
        
        guard let url = URL(string: "https://equipo4.tc2007b.tec.mx:10207/graficasAdminMain") else{
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
          let datosCasosActMain = try jsonDecoder.decode([RecaudacionPorSemana].self, from: data)
        for datoX in datosCasosActMain {
            print(datoX)
        }
        return datosCasosActMain
      }
}
