//
//  DonantesPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantePotencial: Identifiable {
    let id = UUID()
    let nombre: String
    let mesesUltimaDonacion: Int
    let casosSimilares: Int
}

struct DonantesPotencialesComp: View {
    @Binding var tabSeleccionado: Tabs
    let donantes: [DonantePotencial] = [
        DonantePotencial(nombre: "Manuel Rodríguez", mesesUltimaDonacion: 25, casosSimilares: 7),
        DonantePotencial(nombre: "Esperanza Lopez", mesesUltimaDonacion: 22,
            casosSimilares: 5),
        DonantePotencial(nombre: "Javier Herrera", mesesUltimaDonacion: 18, casosSimilares: 2)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Text("DONANTES POTENCIALES")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                Button {
                    tabSeleccionado = .donantes
                } label: {
                    Text("VER TODO")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                }
            }
            .padding(.horizontal, 4)

            HStack(alignment: .top, spacing: 16) {
                ForEach(donantes) { donante in
                        DonantePotencialCard(donante: donante)
                    }
                    .buttonStyle(.plain)
                }
            }.padding(20)
        }
        
    }


struct DonantePotencialCard: View {
    let donante: DonantePotencial

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(donante.nombre.uppercased())
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 0.13, green: 0.34, blue: 0.38))

            Text("ÚLTIMA DONACIÓN:\nHACE \(donante.mesesUltimaDonacion) MESES")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)

            Spacer()

            Text("HAY \(donante.casosSimilares) CASOS SIMILARES A SU ÚLTIMA DONACIÓN")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color(red: 0.13, green: 0.34, blue: 0.38))
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 260, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 0.68, green: 0.82, blue: 0.82))
        )
    }
}

#Preview {
    DonantesPotencialesComp(tabSeleccionado: .constant(.inicio))
}
