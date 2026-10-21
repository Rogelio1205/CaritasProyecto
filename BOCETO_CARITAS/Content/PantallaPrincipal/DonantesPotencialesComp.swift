//
//  DonantesPotencialesComp.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesPotencialesComp: View {
    @Binding var tabSeleccionado: Tabs
    let donantes: [DonantesPotenciales]

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

            if donantes.isEmpty {
                Text("Sin donantes potenciales por ahora")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            } else {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(donantes) { donante in
                        NavigationLink {
                            DonanteDetallado(id: donante.idDonante)
                        } label: {
                            DonantePotencialCard(donante: donante)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(20)
    }
}

struct DonantePotencialCard: View {
    let donante: DonantesPotenciales

    private var textoDonaciones: String {
        if donante.cantidadDonaciones == 1 {
            return "Ha donado: 1 vez"
        } else {
            return "Ha donado: \(donante.cantidadDonaciones) veces"
        }
    }

    private var montoFormateado: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let numero = formatter.string(from: NSNumber(value: donante.donacionPotencial)) ?? "\(Int(donante.donacionPotencial))"
        return "$\(numero)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(donante.nombre)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 0.13, green: 0.34, blue: 0.38))
                .fixedSize(horizontal: false, vertical: true)

            Text(textoDonaciones)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)

            Spacer()

            Text("Donación potencial: \(montoFormateado)")
                .font(.system(size: 18, weight: .bold))
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
    NavigationStack {
        DonantesPotencialesComp(
            tabSeleccionado: .constant(.inicio),
            donantes: [
                DonantesPotenciales(cantidadDonaciones: 1, donacionPotencial: 8000, idDonante: 12, nombre: "Gabriela Moreno"),
                DonantesPotenciales(cantidadDonaciones: 2, donacionPotencial: 2000, idDonante: 9, nombre: "Jorge Cantu"),
                DonantesPotenciales(cantidadDonaciones: 1, donacionPotencial: 2500, idDonante: 14, nombre: "Alejandra Paz")
            ]
        )
    }
}
