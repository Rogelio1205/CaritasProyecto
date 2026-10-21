//
//  FiltroDonantesPotenciales.swift
//  BOCETO_CARITAS
//

import SwiftUI
 
enum ModoFiltroPotencial: CaseIterable, Hashable {
    case cantidadDonaciones
    case donacionPotencial
 
    var titulo: String {
        switch self {
        case .cantidadDonaciones: return "CANTIDAD DE DONACIONES"
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
 
struct FiltroDonantesPotenciales: View {
    let donantes: [DonantesPotenciales]
 
    @State private var modoSeleccionado: ModoFiltroPotencial = .donacionPotencial
    @State private var orden: OrdenPotencial = .mayorAMenor
 
    private var donantesOrdenados: [DonantesPotenciales] {
        let criterio: (DonantesPotenciales) -> Int = modoSeleccionado == .cantidadDonaciones
            ? { $0.cantidadDonaciones }
        : { Int($0.donacionPotencial) }
 
        switch orden {
        case .mayorAMenor:
            return donantes.sorted { criterio($0) > criterio($1) }
        case .menorAMayor:
            return donantes.sorted { criterio($0) < criterio($1) }
        }
    }
 
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
 
            HStack(spacing: 12) {
                Text("FILTRAR POR:")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
 
                FiltroPotencial(seleccion: $modoSeleccionado)
 
                Button {
                    orden.alternar()
                } label: {
                    Image(systemName: orden == .mayorAMenor
                          ? "arrow.down.to.line"
                          : "arrow.up.to.line")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black.opacity(0.7))
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .fill(Color(red: 0.88, green: 0.88, blue: 0.88))
                        )
                }
            }
 
            ScrollView(showsIndicators: true) {
                VStack(spacing: 16) {
                    ForEach(donantesOrdenados) { donante in
                        NavigationLink {
                            DonanteDetallado(id: donante.idDonante)
                        } label: {
                            MostrarDonantePotencial(donante: donante)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 4)
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
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(seleccion == modo ? Color(red: 0.88, green: 0.88, blue: 0.88) : Color.clear)
                    )
                    .contentShape(Capsule())
                    .onTapGesture {
                        seleccion = modo
                    }
            }
        }
        .background(
            Capsule()
                .fill(Color.white)
        )
    }
}
 
struct MostrarDonantePotencial: View {
    let donante: DonantesPotenciales
 
    private var montoFormateado: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let numero = formatter.string(from: NSNumber(value: donante.donacionPotencial)) ?? "\(donante.donacionPotencial)"
        return "$\(numero)"
    }
 
    private var textoDonaciones: String {
        if donante.cantidadDonaciones == 1 {
            return "Ha donado 1 vez"
        } else {
            return "Ha donado \(donante.cantidadDonaciones) veces"
        }
    }
 
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(donante.nombre)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
 
                Text(textoDonaciones)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.8))
            }
 
            Spacer()
 
            VStack(alignment: .center, spacing: -2) {
                Text("DONACIÓN POTENCIAL")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                Text(montoFormateado)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
            }
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
        FiltroDonantesPotenciales(donantes: [
            DonantesPotenciales(cantidadDonaciones: 1, donacionPotencial: 8000, idDonante: 12, nombre: "Gabriela Moreno"),
            DonantesPotenciales(cantidadDonaciones: 1, donacionPotencial: 2500, idDonante: 14, nombre: "Alejandra Paz"),
            DonantesPotenciales(cantidadDonaciones: 1, donacionPotencial: 2500, idDonante: 1, nombre: "Oscar Ramirez"),
            DonantesPotenciales(cantidadDonaciones: 2, donacionPotencial: 2000, idDonante: 9, nombre: "Jorge Cantu"),
            DonantesPotenciales(cantidadDonaciones: 1, donacionPotencial: 1000, idDonante: 3, nombre: "Santiago Reyes"),
            DonantesPotenciales(cantidadDonaciones: 2, donacionPotencial: 500, idDonante: 17, nombre: "Miguel Angel Soto")
        ])
        .padding()
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
    }
}
 
