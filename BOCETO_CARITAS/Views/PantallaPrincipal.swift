//
//  PantallaPrincipal.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 19/10/26.
//

import SwiftUI

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
