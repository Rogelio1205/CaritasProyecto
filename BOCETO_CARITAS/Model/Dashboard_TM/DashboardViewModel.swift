//
//  DashboardViewModel.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 23/09/26.
//

import SwiftUI
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var data: DashboardScreen?
    @Published var errorMessage: String?
    @Published var isLoading = false

    func cargar(idUsuario: Int) async {
        isLoading = true
        defer { isLoading = false }
        do {
            data = try await obtenerDashboard(idUsuario: idUsuario)
            errorMessage = nil
        } catch {
            errorMessage = "No se pudo cargar el dashboard: \(error.localizedDescription)"
        }
    }
}
