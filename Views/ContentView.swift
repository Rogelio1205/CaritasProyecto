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

    private func icono(_ nombre: String) -> Image {
        let config = UIImage.SymbolConfiguration(pointSize: 41, weight: .semibold)
        let imagen = UIImage(systemName: nombre, withConfiguration: config)!
            .withRenderingMode(.alwaysTemplate)
        return Image(uiImage: imagen)
    }

    var body: some View {
        TabView(selection: $tabSeleccionado) {
            NavigationStack {
                ScrollView {
                    PantallaPrincipal(idUsuario: idUsuario,
                                      tabSeleccionado: $tabSeleccionado)
                }
            }
            .tabItem { icono("house") }
            .tag(Tabs.inicio)

            NavigationStack {
                ScrollView { DonantesEnRiesgo() }
            }
            .tabItem { icono("exclamationmark.triangle") }
            .tag(Tabs.riesgo)

            NavigationStack {
                ScrollView { DonantesPotencialesVista() }
            }
            .tabItem { icono("person.fill") }
            .tag(Tabs.donantes)

            NavigationStack {
                ScrollView { DonantesAltoValorVista() }
            }
            .tabItem { icono("leaf.fill") }
            .tag(Tabs.potenciales)
        }
        .tint(ColorConstants.mainColor)
        .environment(\.horizontalSizeClass, .compact)
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
