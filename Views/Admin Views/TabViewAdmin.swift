//
//  TabViewAdmin.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 09/10/26.
//

import SwiftUI

struct TabViewAdmin: View {
    var body: some View {
        VStack { // VStack princiapl
            TabView{ // TabView
                AdminInicio()
                    .tabItem {
                        Label("", systemImage: "house")
                    }
                RecaudacionAreasView()
                    .tabItem {
                        Label("", systemImage: "chart.pie.fill")
                    }
                DonantesTopView()
                    .tabItem {
                        Label("", systemImage: "star.fill")
                    }
                
                // Agregar las pantallas faltantes
            } // TabView
            .tint(ColorConstants.mainColor)
            .environment(\.horizontalSizeClass, .compact)
        } // Vstack Principal
    }
}

#Preview {
    TabViewAdmin()
}
