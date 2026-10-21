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


#Preview {
    ContentView(idUsuario: 1)
}
