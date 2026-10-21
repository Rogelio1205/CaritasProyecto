//
//  DonantesAltoValorComp.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesAltoValorComp: View {

    @Binding var tabSeleccionado: Tabs
    let donantes: [DonanteAltoValor]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("DONANTES DE ALTO VALOR")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                Button {
                    tabSeleccionado = .potenciales
                } label: {
                    Text("VER TODO")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                }
            }
            .padding(.horizontal, 4)

            if donantes.isEmpty {
                Text("Sin donantes de alto valor por ahora")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            } else {
                VStack(spacing: 16) {
                    ForEach(donantes) { donante in
                        NavigationLink {
                            DonanteDetallado(id: donante.idDonante)
                        } label: {
                            MostrarAltoValor(donante: donante)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(20)
    }
}


#Preview {
    NavigationStack {
        DonantesAltoValorComp(
            tabSeleccionado: .constant(.inicio),
            donantes: [
                DonanteAltoValor(idDonante: 1, nombre: "Laura Fuentes", mesesUltimaDonacion: 5, diasSinDonar: 10, totalDonado: 18459),
                DonanteAltoValor(idDonante: 2, nombre: "Gustavo Gutierrez", mesesUltimaDonacion: 6, diasSinDonar: 10, totalDonado: 14395),
                DonanteAltoValor(idDonante: 3, nombre: "Octavio Castro", mesesUltimaDonacion: 1, diasSinDonar: 10, totalDonado: 9503)
            ]
        )
    }
    .frame(width: 900)
}
