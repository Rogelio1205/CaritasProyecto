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

#Preview {
    ContentView(idUsuario: 1)
}
