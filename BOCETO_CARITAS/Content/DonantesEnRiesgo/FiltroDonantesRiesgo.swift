//
//  FiltroDonantesRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum FiltroRiesgo: CaseIterable, Hashable {
    case todos
    case alto
    case medio
    case bajo
    case inactivo

    var titulo: String {
        switch self {
        case .todos: return "TODOS"
        case .alto: return "RIESGO ALTO"
        case .medio: return "RIESGO MEDIO"
        case .bajo: return "RIESGO BAJO"
        case .inactivo: return "INACTIVO"
        }
    }

    var colorFondoInactivo: Color {
        switch self {
        case .todos: return Color(red: 0.85, green: 0.85, blue: 0.85)
        case .alto: return Color(red: 0.93, green: 0.87, blue: 0.87)
        case .medio: return Color(red: 0.92, green: 0.90, blue: 0.83)
        case .bajo: return Color(red: 0.87, green: 0.90, blue: 0.85)
        case .inactivo: return Color(red: 0.88, green: 0.88, blue: 0.88)
        }
    }

    var colorTextoInactivo: Color {
        switch self {
        case .todos: return .black
        case .alto: return Color(red: 0.55, green: 0.15, blue: 0.15)
        case .medio: return Color(red: 0.53, green: 0.42, blue: 0.10)
        case .bajo: return Color(red: 0.14, green: 0.33, blue: 0.14)
        case .inactivo: return .black
        }
    }

    var colorFondoSeleccionado: Color {
        switch self {
        case .todos: return Color(red: 0.3, green: 0.3, blue: 0.3)
        case .alto: return Color(red: 0.45, green: 0.12, blue: 0.12)
        case .medio: return Color(red: 0.53, green: 0.42, blue: 0.10)
        case .bajo: return Color(red: 0.14, green: 0.33, blue: 0.14)
        case .inactivo: return Color(red: 0.3, green: 0.3, blue: 0.3)
        }
    }
}

struct DonanteRiesgoSimulado: Identifiable {
    let id = UUID()
    let nombre: String
    let ultimaDonacion: String
    let riesgo: FiltroRiesgo
}

struct FiltroDonantesRiesgo: View {
    @State private var filtroSeleccionado: FiltroRiesgo = .alto

    let donantesSimulados: [DonanteRiesgoSimulado] = [
        DonanteRiesgoSimulado(nombre: "Oscar Ramírez", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 2 AÑOS", riesgo: .alto),
        DonanteRiesgoSimulado(nombre: "Danna Sepúlveda", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 1 AÑO", riesgo: .alto),
        DonanteRiesgoSimulado(nombre: "Rogelio García", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 13 MESES", riesgo: .alto),
        DonanteRiesgoSimulado(nombre: "Maricela Pacheco", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 13 MESES", riesgo: .alto),
        DonanteRiesgoSimulado(nombre: "Lucía Medina", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 15 MESES", riesgo: .alto),
        DonanteRiesgoSimulado(nombre: "Pablo Gomez", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 17 MESES", riesgo: .alto),
        DonanteRiesgoSimulado(nombre: "María Estrada", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 6 MESES", riesgo: .medio),
        DonanteRiesgoSimulado(nombre: "Carlos Nuñez", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 7 MESES", riesgo: .medio),
        DonanteRiesgoSimulado(nombre: "Andrea Solís", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 2 MESES", riesgo: .bajo),
        DonanteRiesgoSimulado(nombre: "Jorge Villareal", ultimaDonacion: "ÚLTIMA DONACIÓN HACE 3 MESES", riesgo: .bajo),
        DonanteRiesgoSimulado(nombre: "Fernanda Ríos", ultimaDonacion: "SIN DONACIONES REGISTRADAS", riesgo: .inactivo)
    ]

    private var donantesFiltrados: [DonanteRiesgoSimulado] {
        if filtroSeleccionado == .todos {
            return donantesSimulados
        }
        return donantesSimulados.filter { $0.riesgo == filtroSeleccionado }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            HStack(spacing: 12) {
                Text("FILTRAR POR:")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(FiltroRiesgo.allCases, id: \.self) { filtro in
                            FiltroDonanteRiesgo(
                                filtro: filtro,
                                isSelected: filtro == filtroSeleccionado
                            )
                            .onTapGesture {
                                filtroSeleccionado = filtro
                            }
                        }
                    }
                }
            }

            VStack(spacing: 12) {
                ForEach(donantesFiltrados) { donante in
                        MostrarDonanteRiesgo(donante: donante)
                }
            }
        }
    }
}

struct FiltroDonanteRiesgo: View {
    let filtro: FiltroRiesgo
    let isSelected: Bool

    var body: some View {
        Text(filtro.titulo)
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(isSelected ? .white : filtro.colorTextoInactivo)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(isSelected ? filtro.colorFondoSeleccionado : filtro.colorFondoInactivo)
            )
    }
}

struct MostrarDonanteRiesgo: View {
    let donante: DonanteRiesgoSimulado

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
                    .foregroundColor(donante.riesgo.colorFondoSeleccionado.opacity(0.85))
                Text(donante.riesgo.titulo.replacingOccurrences(of: "RIESGO ", with: ""))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(donante.riesgo.colorFondoSeleccionado)
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
            FiltroDonantesRiesgo()
                .padding()
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
    }
}
