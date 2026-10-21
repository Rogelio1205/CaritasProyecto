//
//  FiltroDonantesAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum ModoFiltroAltoValor: CaseIterable, Hashable {
    case ultimaActividad
    case totalDonado

    var titulo: String {
        switch self {
        case .ultimaActividad: return "ÚLTIMA ACTIVIDAD"
        case .totalDonado: return "TOTAL DONADO"
        }
    }
}

enum OrdenAltoValor {
    case mayorAMenor
    case menorAMayor

    mutating func alternar() {
        self = self == .mayorAMenor ? .menorAMayor : .mayorAMenor
    }
}

struct DonanteAltoValorSimulado: Identifiable {
    let id = UUID()
    let nombre: String
    let ultimaActividadDias: Int
    let totalDonado: Double
}

struct FiltroDonantesAltoValor: View {
    @State private var modoSeleccionado: ModoFiltroAltoValor = .ultimaActividad
    @State private var orden: OrdenAltoValor = .mayorAMenor

    let donantesSimulados: [DonanteAltoValorSimulado] = [
        DonanteAltoValorSimulado(nombre: "Miguel Rodríguez", ultimaActividadDias: 22, totalDonado: 48236),
        DonanteAltoValorSimulado(nombre: "Esperanza Lopez", ultimaActividadDias: 8, totalDonado: 55234),
        DonanteAltoValorSimulado(nombre: "Javier Herrera", ultimaActividadDias: 15, totalDonado: 38306),
        DonanteAltoValorSimulado(nombre: "Samuel Mendez", ultimaActividadDias: 30, totalDonado: 27906),
        DonanteAltoValorSimulado(nombre: "Sergio Carrillo", ultimaActividadDias: 5, totalDonado: 24690),
        DonanteAltoValorSimulado(nombre: "Rocío Gutierrez", ultimaActividadDias: 12, totalDonado: 26840),
        DonanteAltoValorSimulado(nombre: "Carlos Vázquez", ultimaActividadDias: 45, totalDonado: 26826)
    ]

    private var donantesOrdenados: [DonanteAltoValorSimulado] {
        let criterio: (DonanteAltoValorSimulado) -> Double = modoSeleccionado == .ultimaActividad
            ? { Double($0.ultimaActividadDias) }
            : { $0.totalDonado }

        switch orden {
        case .mayorAMenor:
            return donantesSimulados.sorted { criterio($0) > criterio($1) }
        case .menorAMayor:
            return donantesSimulados.sorted { criterio($0) < criterio($1) }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(spacing: 12) {
                Text("FILTRAR POR:")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)

                FiltroAltoValor(seleccion: $modoSeleccionado)

                Spacer()

                Button {
                    orden.alternar()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black.opacity(0.7))
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(Color(red: 0.88, green: 0.88, blue: 0.88))
                        )
                }
            }

            VStack(spacing: 12) {
                ForEach(donantesOrdenados) { donante in
                        MostrarAltoValor(donante: donante)

                }
            }
        }
    }
}

struct FiltroAltoValor: View {
    @Binding var seleccion: ModoFiltroAltoValor

    var body: some View {
        HStack(spacing: 0) {
            ForEach(ModoFiltroAltoValor.allCases, id: \.self) { modo in
                Text(modo.titulo)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(seleccion == modo ? Color(red: 0.85, green: 0.85, blue: 0.85) : Color.clear)
                    )
                    .onTapGesture {
                        seleccion = modo
                    }
            }
        }
        .background(
            Capsule()
                .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
        )
    }
}

struct MostrarAltoValor: View {
    let donante: DonanteAltoValorSimulado

    private var cantidadFormato: String {
        let formato = NumberFormatter()
        formato.numberStyle = .decimal
        formato.groupingSeparator = ","
        formato.maximumFractionDigits = 0
        let numero = formato.string(from: NSNumber(value: donante.totalDonado)) ?? "\(Int(donante.totalDonado))"
        return "$\(numero) PESOS"
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(donante.nombre.uppercased())
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text("ÚLTIMA ACTIVIDAD HACE \(donante.ultimaActividadDias) DÍAS")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("TOTAL DONADO")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))
                Text(cantidadFormato)
                    .font(.system(size: 15, weight: .bold))
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
    NavigationStack {
        ScrollView {
            FiltroDonantesAltoValor()
                .padding()
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
    }
}
