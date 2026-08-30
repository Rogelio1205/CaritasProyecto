//
//  NavBar.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum Tabs: CaseIterable {
    case inicio
    case riesgo
    case donantes
    case potenciales

    var icono: String {
        switch self {
        case .inicio: return "house"
        case .riesgo: return "exclamationmark.triangle"
        case .donantes: return "person.fill"
        case .potenciales: return "leaf.fill"
        }
    }
}

struct NavBar: View {
    @Binding var tabSeleccionado: Tabs

    private let colorFondo = Color(red: 0.79, green: 0.89, blue: 0.90)

    var body: some View {
        HStack {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Spacer()
                BotonTabs(tab: tab)
                    .onTapGesture {
                        tabSeleccionado = tab
                    }
                Spacer()
            }
        }
        .padding(.vertical, 28)
        .background(
            Capsule()
                .fill(colorFondo)
        )
        .padding(.horizontal, 20)
    }
}

struct BotonTabs: View {
    let tab: Tabs

    var body: some View {
        Image(systemName: tab.icono)
            .font(.system(size: 34, weight: .semibold))
            .foregroundColor(.black)
            .frame(width: 44, height: 44)
    }
}

#Preview {
    ContentView()
}
