//
//  FiltroDonantesPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum ModoFiltroPotencial: CaseIterable, Hashable {
    case casosSimilares
    case donacionPotencial

    var titulo: String {
        switch self {
        case .casosSimilares: return "CASOS SIMILARES"
        case .donacionPotencial: return "DONACIÓN POTENCIAL"
        }
    }
}

enum OrdenPotencial {
    case mayorAMenor
    case menorAMayor

    mutating func alternar() {
        self = self == .mayorAMenor ? .menorAMayor : .mayorAMenor
    }
}

struct DonantePotencialSimulado: Identifiable {
    let id = UUID()
    let nombre: String
    let casosSimilares: Int
    let donacionPotencial: Double
}

struct FiltroDonantesPotenciales: View {
    @State private var modoSeleccionado: ModoFiltroPotencial = .casosSimilares
    @State private var orden: OrdenPotencial = .mayorAMenor

    let donantesSimulados: [DonantePotencialSimulado] = [
        DonantePotencialSimulado(nombre: "Miguel Rodríguez", casosSimilares: 7, donacionPotencial: 10236),
        DonantePotencialSimulado(nombre: "Esperanza Lopez", casosSimilares: 5, donacionPotencial: 15234),
        DonantePotencialSimulado(nombre: "Javier Herrera", casosSimilares: 2, donacionPotencial: 8306),
        DonantePotencialSimulado(nombre: "Samuel Mendez", casosSimilares: 2, donacionPotencial: 7906),
        DonantePotencialSimulado(nombre: "Sergio Carrillo", casosSimilares: 1, donacionPotencial: 4690),
        DonantePotencialSimulado(nombre: "Rocío Gutierrez", casosSimilares: 1, donacionPotencial: 6840),
        DonantePotencialSimulado(nombre: "Carlos Vázquez", casosSimilares: 1, donacionPotencial: 1230)
    ]

    private var donantesOrdenados: [DonantePotencialSimulado] {
        let criterio: (DonantePotencialSimulado) -> Double = modoSeleccionado == .casosSimilares
            ? { Double($0.casosSimilares) }
            : { $0.donacionPotencial }

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

                FiltroPotencial(seleccion: $modoSeleccionado)

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
                    MostrarDonantePotencial(donante: donante)
                    
                }
            }
        }
    }
}

struct FiltroPotencial: View {
    @Binding var seleccion: ModoFiltroPotencial

    var body: some View {
        HStack(spacing: 0) {
            ForEach(ModoFiltroPotencial.allCases, id: \.self) { modo in
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

struct MostrarDonantePotencial: View {
    let donante: DonantePotencialSimulado

    private var montoFormateado: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let numero = formatter.string(from: NSNumber(value: donante.donacionPotencial)) ?? "\(Int(donante.donacionPotencial))"
        return "$\(numero) PESOS"
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(donante.nombre.uppercased())
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text("HAY \(donante.casosSimilares) CASOS SIMILARES A SU ÚLTIMA DONACIÓN")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("DONACIÓN POTENCIAL")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))
                Text(montoFormateado)
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
            FiltroDonantesPotenciales()
                .padding()
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
    }
}
