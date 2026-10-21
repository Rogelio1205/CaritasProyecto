//
//  DonanteAltoValorViewModel.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 15/10/26.
//

import SwiftUI
import Combine

@MainActor
class DonanteAltoValorViewModel: ObservableObject {
    @Published var data: DonanteAltoValorScreen?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func cargar() async {
        isLoading = true
        defer {
            isLoading = false
}
        
        do {
            data = try await obtenerDonanteAltoValor()
            errorMessage = nil
        } catch {
            errorMessage = "No se pudo cargar los Donantes de Alto Valor: \(error.localizedDescription)"
        }
    }
}
