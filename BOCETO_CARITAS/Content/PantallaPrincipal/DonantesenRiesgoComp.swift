//
//  DonantesEnRiesgoComp.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum NivelRiesgo {
    case alto
    case medio
    case bajo

    init(api: String) {
        switch api {
        case "alto": self = .alto
        case "bajo": self = .bajo
        default:     self = .medio
        }
    }

    var texto: String {
        switch self {
        case .alto: return "RIESGO ALTO"
        case .medio: return "RIESGO MEDIO"
        case .bajo: return "RIESGO BAJO"
        }
    }

    var colorTexto: Color {
        switch self {
        case .alto: return Color(red: 0.55, green: 0.15, blue: 0.15)
        case .medio: return Color(red: 0.53, green: 0.42, blue: 0.10)
        case .bajo: return Color(red: 0.14, green: 0.33, blue: 0.14)
        }
    }

    var colorFondo: Color {
        switch self {
        case .alto: return Color(red: 0.98, green: 0.93, blue: 0.93)
        case .medio: return Color(red: 0.98, green: 0.96, blue: 0.88)
        case .bajo: return Color(red: 0.90, green: 0.96, blue: 0.90)
        }
    }
}

struct DonantesEnRiesgoComp: View {

    @Binding var tabSeleccionado: Tabs
    let donantes: [DonanteRiesgo]

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

            if donantes.isEmpty {
                Text("Sin donantes en riesgo por ahora")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            } else {
                VStack(spacing: 12) {
                    ForEach(donantes) { donante in
                        NavigationLink {
                            DonanteDetallado(id: donante.idDonante)
                        } label: {
                            MuestraDonante(donante: donante)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(20)
    }
}

struct MuestraDonante: View {
    let donante: DonanteRiesgo

    private var nivel: NivelRiesgo { NivelRiesgo(api: donante.nivel) }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(donante.nombre)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text(formatoFecha(donante.mesesUltimaDonacion))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(nivel.texto)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(nivel.colorTexto)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(nivel.colorFondo)
                )
                .padding(.trailing, 12)

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color.gray.opacity(0.4))
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
    NavigationStack {
        DonantesEnRiesgoComp(
            tabSeleccionado: .constant(.inicio),
            donantes: [
                DonanteRiesgo(idDonante: 1, nombre: "Oscar Ramírez", mesesUltimaDonacion: 24, nivel: "alto"),
                DonanteRiesgo(idDonante: 2, nombre: "Danna Sepúlveda", mesesUltimaDonacion: 12, nivel: "alto"),
                DonanteRiesgo(idDonante: 3, nombre: "María Estrada", mesesUltimaDonacion: 6, nivel: "medio")
            ]
        )
    }
    .frame(width: 860)
}
