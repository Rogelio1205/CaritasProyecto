//
//  DonantePotencialService.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 13/10/26.
//

import Foundation

private let urlBaseDonanteRiesgo = "https://equipo4.tc2007b.tec.mx:10207/donantepotencial"

func obtenerDonantePotencial() async throws -> DonantePotencialScreen {

    guard let url = URL(string: urlBaseDonanteRiesgo) else {
        print("URL incorrecto")
        throw URLError(.badURL)
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
        print("Respuesta no válida del servidor")
        throw URLError(.badServerResponse)
    }

    guard httpResponse.statusCode == 200 else {
        print("Código de error del API: \(httpResponse.statusCode)")
        throw URLError(.badServerResponse)
    }

    return try JSONDecoder().decode(DonantePotencialScreen.self, from: data)
}
