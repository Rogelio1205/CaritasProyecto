//
//  DashboardService.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import Foundation

private let urlBaseDashboard = "http://10.14.255.41:10206/dashboard"

func obtenerDashboard(idUsuario: Int) async throws -> DashboardScreen {

    guard var components = URLComponents(string: urlBaseDashboard) else {
        print("URL incorrecto")
        throw URLError(.badURL)
    }
    components.queryItems = [URLQueryItem(name: "idUsuario", value: String(idUsuario))]

    guard let url = components.url else {
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

    return try JSONDecoder().decode(DashboardScreen.self, from: data)
}
