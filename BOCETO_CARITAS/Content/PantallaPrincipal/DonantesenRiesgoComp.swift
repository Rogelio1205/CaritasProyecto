//
//  DonantesEnRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum NivelRiesgo {
    case alto
    case medio
    case bajo

    var texto: String {
        switch self {
        case .alto: return "ALTO"
        case .medio: return "MEDIO"
        case .bajo: return "BAJO"
        }
    }

    var color: Color {
        switch self {
        case .alto: return Color(red: 0.55, green: 0.15, blue: 0.15)
        case .medio: return Color(red: 0.53, green: 0.42, blue: 0.10)
        case .bajo: return Color(red: 0.14, green: 0.33, blue: 0.14)
        }
    }
}

struct DonantesEnRiesgoComp: View {

    @Binding var tabSeleccionado: Tabs

    let donantes: [Donante] = [
        Donante(nombre: "Oscar Ramírez", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 2 AÑOS", riesgo: .alto),
        Donante(nombre: "Danna Sepúlveda", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 1 AÑO", riesgo: .alto),
        Donante(nombre: "Rogelio García", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 13 MESES", riesgo: .alto),
        Donante(nombre: "María Estrada", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 6 MESES", riesgo: .medio)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text("DONANTES EN RIESGO")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                Button {
                    tabSeleccionado = .riesgo
                } label: {
                    Text("VER TODO")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                }
            }
            .padding(.horizontal, 4)

            VStack(spacing: 12) {
                ForEach(donantes) { donante in
                        MuestraDonante(donante: donante)
                    }
                    .buttonStyle(.plain)
                }
            }.padding(20)
        }
        
    }


struct MuestraDonante: View {
    let donante: Donante

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(donante.nombre.uppercased())
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text(donante.ultimaDonacion)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("RIESGO")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(donante.riesgo.color.opacity(0.75))
                Text(donante.riesgo.texto)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(donante.riesgo.color)
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
    DonantesEnRiesgoComp(tabSeleccionado: .constant(.inicio))
        .frame(width: 860)
}
