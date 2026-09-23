//
//  ContentView.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI
struct ContentView: View {
    @State private var tabSeleccionado: Tabs = .inicio

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(red: 0.94, green: 0.94, blue: 0.94)
                    .ignoresSafeArea()

                ScrollView {
                    VStack {
                        switch tabSeleccionado {
                        case .inicio:
                            PantallaPrincipal(tabSeleccionado: $tabSeleccionado)
                        case .riesgo:
                            DonantesEnRiesgo()
                        case .donantes:
                            DonantesPotenciales()
                        case .potenciales:
                            DonantesAltoValor()
                        }

                        Color.clear.frame(height: 120)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }

                NavBar(tabSeleccionado: $tabSeleccionado)
                    .padding(.bottom, 12)
            }
            
            }
        }
    }


struct PantallaPrincipal: View {
    @Binding var tabSeleccionado: Tabs

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Header()
            Resumen()
            DonantesEnRiesgoComp(tabSeleccionado: $tabSeleccionado)
            DonantesPotencialesComp(tabSeleccionado: $tabSeleccionado)
            DonantesAltoValorComp(tabSeleccionado: $tabSeleccionado)
        }
    }
}

#Preview {
    ContentView()
}
