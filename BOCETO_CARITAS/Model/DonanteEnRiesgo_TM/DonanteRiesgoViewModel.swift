//
//  DonanteRiesgoViewModel.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 07/10/26.
//

import SwiftUI
import Combine

@MainActor
class DonanteRiesgoViewModel: ObservableObject {
    @Published var data: DonanteRiesgoScreen?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func cargar() async {
        isLoading = true
        defer {
            isLoading = false
}
        
        do {
            data = try await obtenerDonanteRiesgo()
            errorMessage = nil
        } catch {
            errorMessage = "No se pudo cargar los Donantes en Riesgo: \(error.localizedDescription)"
        }
    }
}



