//
//  ContentView.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct ContentView: View {
    let idUsuario: Int
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
                            PantallaPrincipal(idUsuario: idUsuario,
                                              tabSeleccionado: $tabSeleccionado)
                        case .riesgo:
                            DonantesEnRiesgo()
                        case .donantes:
                            DonantesPotenciales()
                        case .potenciales:
                            DonantesAltoValor()
                        }

                        Color.clear.frame(height: 120)
                    }
                
                }

                NavBar(tabSeleccionado: $tabSeleccionado)
                    .padding(.bottom, 12)
            }
        }
    }
}

struct PantallaPrincipal: View {
    let idUsuario: Int
    @Binding var tabSeleccionado: Tabs
    @StateObject private var viewmodel = DashboardViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Header().padding(.bottom, 42).padding(.top,-30)

            if let dashboard = viewmodel.data {
                Resumen(meta: dashboard.meta, riesgo: dashboard.riesgo).padding(.horizontal,16)
                DonantesEnRiesgoComp(tabSeleccionado: $tabSeleccionado,
                                     donantes: dashboard.donantesEnRiesgo).padding(.horizontal,16)
                DonantesPotencialesComp(tabSeleccionado: $tabSeleccionado,
                                        donantes: dashboard.donantesPotenciales).padding(.horizontal,16)
                DonantesAltoValorComp(tabSeleccionado: $tabSeleccionado,
                                      donantes: dashboard.donantesAltoValor).padding(.horizontal,16)
            } else if viewmodel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 80)
            } else if let error = viewmodel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .task { await viewmodel.cargar(idUsuario: idUsuario) }
        
    }
}

#Preview {
    ContentView(idUsuario: 1)
}
