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

    init(api: String) {
        switch api {
        case "alto": self = .alto
        case "medio": self = .medio
        case "bajo": self = .bajo
        default: self = .inactivo
        }
    }

    var titulo: String {
        switch self {
        case .todos: return "TODOS"
        case .alto: return "RIESGO ALTO"
        case .medio: return "RIESGO MEDIO"
        case .bajo: return "RIESGO BAJO"
        case .inactivo: return "INACTIVO"
        }
    }

    var colorTexto: Color {
        switch self {
        case .todos: return .black
        case .alto: return Color(red: 0.55, green: 0.15, blue: 0.15)
        case .medio: return Color(red: 0.53, green: 0.42, blue: 0.10)
        case .bajo: return Color(red: 0.14, green: 0.33, blue: 0.14)
        case .inactivo: return Color(red: 0.25, green: 0.25, blue: 0.25)
        }
    }

    var colorFondo: Color {
        switch self {
        case .todos: return Color(red: 0.85, green: 0.85, blue: 0.85)
        case .alto: return Color(red: 0.93, green: 0.87, blue: 0.87)
        case .medio: return Color(red: 0.92, green: 0.90, blue: 0.83)
        case .bajo: return Color(red: 0.87, green: 0.90, blue: 0.85)
        case .inactivo: return Color(red: 0.88, green: 0.88, blue: 0.88)
        }
    }
}

struct FiltroDonantesRiesgo: View {
    let donantes: [DonanteRiesgo]
    @State private var filtroSeleccionado: FiltroRiesgo = .todos

    private var donantesFiltrados: [DonanteRiesgo] {
        if filtroSeleccionado == .todos {
            return donantes
        }
        return donantes.filter { FiltroRiesgo(api: $0.nivel) == filtroSeleccionado }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

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
                    .padding(.vertical, 2)
                }
            }

            if donantesFiltrados.isEmpty {
                Text("Sin donantes en esta categoría")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            } else {
                VStack(spacing: 16) {
                    ForEach(donantesFiltrados) { donante in
                        MostrarDonanteRiesgo(donante: donante)
                    }
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
            .foregroundColor(filtro.colorTexto)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(isSelected ? filtro.colorFondo : Color.clear)
            )
            .overlay(
                Capsule()
                    .stroke(filtro.colorTexto, lineWidth: 1)
                    .opacity(isSelected ? 0 : 1)
            )
    }
}

struct MostrarDonanteRiesgo: View {
    let donante: DonanteRiesgo

    private var nivel: FiltroRiesgo { FiltroRiesgo(api: donante.nivel) }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(donante.nombre)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text(formatoFecha(donante.mesesUltimaDonacion))
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.8))
            }

            Spacer()

            Text(nivel.titulo)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(nivel.colorTexto)
                .frame(width: 210)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(nivel.colorFondo)
                )
                .padding(.trailing, 24)

            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color.gray.opacity(0.4))
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 32)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    NavigationStack {
        ScrollView {
            FiltroDonantesRiesgo(donantes: [
                DonanteRiesgo(idDonante: 1, nombre: "Oscar Ramírez", mesesUltimaDonacion: 24, nivel: "alto"),
                DonanteRiesgo(idDonante: 2, nombre: "Danna Sepúlveda", mesesUltimaDonacion: 12, nivel: "alto"),
                DonanteRiesgo(idDonante: 3, nombre: "María Estrada", mesesUltimaDonacion: 6, nivel: "medio"),
                DonanteRiesgo(idDonante: 4, nombre: "Andrea Solís", mesesUltimaDonacion: 2, nivel: "bajo")
            ])
            .padding()
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
    }
}
