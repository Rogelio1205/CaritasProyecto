//
//  DonantesEnRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesEnRiesgo: View {
    @StateObject private var viewModel = DonanteRiesgoViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Header().padding(.bottom, 42).padding(.top,-30)

            if let donanteRiesgo = viewModel.data {
                ResumenRiesgo(riesgo: donanteRiesgo.riesgo).padding(.horizontal,16)

                FiltroDonantesRiesgo(donantes: donanteRiesgo.donantesEnRiesgo)
                    .padding(.vertical, 30).padding(.horizontal,16)
            }
            else if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .task {
            await viewModel.cargar()
        }
    }
}

#Preview {
    DonantesEnRiesgo()
}
