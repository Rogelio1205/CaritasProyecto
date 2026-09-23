//
//  DonantesAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonanteAltoValor: Identifiable {
    let id = UUID()
    let nombre: String
    let mesesUltimaDonacion: Int
    let totalDonado: Double
}

struct DonantesAltoValorComp: View {

    @Binding var tabSeleccionado: Tabs

    let donantes: [DonanteAltoValor] = [
        DonanteAltoValor(nombre: "Laura Fuentes", mesesUltimaDonacion: 5, totalDonado: 18459),
        DonanteAltoValor(nombre: "Gustavo Gutierrez", mesesUltimaDonacion: 6, totalDonado: 14395),
        DonanteAltoValor(nombre: "Margarita Aguilar", mesesUltimaDonacion: 11, totalDonado: 10694),
        DonanteAltoValor(nombre: "Octavio Castro", mesesUltimaDonacion: 2, totalDonado: 9503)
    ]

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

            VStack(spacing: 12) {
                ForEach(donantes) { donante in
                        MuestraDonanteAltoValor(donante: donante)
                }
            }
        }
        .padding(20)
    }
}

struct MuestraDonanteAltoValor: View {
    let donante: DonanteAltoValor

    private var totalFormateado: String {
        let formato = NumberFormatter()
        formato.numberStyle = .decimal
        formato.groupingSeparator = ","
        let numero = formato.string(from: NSNumber(value: donante.totalDonado)) ?? "\(Int(donante.totalDonado))"
        return "$\(numero) pesos"
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(donante.nombre)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text("Última donación hace \(donante.mesesUltimaDonacion) meses")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("Total donado")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.gray)
                Text(totalFormateado)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(.trailing, 12)

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.gray.opacity(0.5))
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    DonantesAltoValorComp(tabSeleccionado: .constant(.inicio))
        .frame(width: 900)
}
