//
//  DonantePotencialViewModel.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 13/10/26.
//

import SwiftUI
import Combine

@MainActor
class DonantePotencialViewModel: ObservableObject {
    @Published var data: DonantePotencialScreen?
    @Published var errorMessage: String?
    @Published var isLoading = false

    func cargar() async {
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            data = try await obtenerDonantePotencial()
            errorMessage = nil
        } catch {
            errorMessage = "No se pudo cargar los Donantes Potenciales: \(error.localizedDescription)"
        }
    }
}
