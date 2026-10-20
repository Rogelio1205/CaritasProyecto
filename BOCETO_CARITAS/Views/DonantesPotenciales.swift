//
//  DonantesPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesPotencialesVista: View {
    @StateObject private var viewModel = DonantePotencialViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Header().padding(.bottom, 42).padding(.top,-30)

            if let donantePotencial = viewModel.data {
                ResumenPotenciales(resumen: donantePotencial.resumen).padding(.horizontal,16)

                FiltroDonantesPotenciales(donantes: donantePotencial.donantesPotenciales)
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
    DonantesPotencialesVista()
}
