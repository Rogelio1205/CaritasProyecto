//
//  FiltroDonantesAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

enum ModoFiltroAltoValor: CaseIterable, Hashable {
    case masDonado
    case donacionMasReciente

    var titulo: String {
        switch self {
        case .masDonado: return "MÁS DONADO"
        case .donacionMasReciente: return "DONACIÓN MÁS RECIENTE"
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

struct FiltroDonantesAltoValor: View {
    let donantes: [DonanteAltoValor]

    @State private var modoSeleccionado: ModoFiltroAltoValor = .masDonado
    @State private var orden: OrdenAltoValor = .mayorAMenor

    private func criterio(_ donante: DonanteAltoValor) -> Double {
        switch modoSeleccionado {
        case .masDonado:
            return donante.totalDonado
        case .donacionMasReciente:
            let dias = donante.diasSinDonar ?? (donante.mesesUltimaDonacion * 30)
            return -Double(dias)
        }
    }

    private var donantesOrdenados: [DonanteAltoValor] {
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

                FiltroAltoValor(seleccion: $modoSeleccionado)

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
                            MostrarAltoValor(donante: donante)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 4)
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

struct MostrarAltoValor: View {
    let donante: DonanteAltoValor

    private var montoFormateado: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let numero = formatter.string(from: NSNumber(value: donante.totalDonado)) ?? "\(Int(donante.totalDonado))"
        return "$\(numero)"
    }

    private var textoUltimaDonacion: String {
        let meses = donante.mesesUltimaDonacion
        if meses >= 1 {
            return "Última donación hace \(meses) \(meses == 1 ? "mes" : "meses")"
        } else if let dias = donante.diasSinDonar {
            return "Última donación hace \(dias) \(dias == 1 ? "día" : "días")"
        } else {
            return "Última donación reciente"
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(donante.nombre)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

                Text(textoUltimaDonacion)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.8))
            }

            Spacer()

            VStack(alignment: .center, spacing: -2) {
                Text("TOTAL DONADO")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                Text(montoFormateado)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
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
    FiltroDonantesAltoValor(donantes: [
        DonanteAltoValor(idDonante: 1, nombre: "Laura Fuentes", mesesUltimaDonacion: 5, diasSinDonar: 150, totalDonado: 10236),
        DonanteAltoValor(idDonante: 2, nombre: "Juan Gutierrez", mesesUltimaDonacion: 6, diasSinDonar: 180, totalDonado: 9541),
        DonanteAltoValor(idDonante: 3, nombre: "Rebeca Aguilar", mesesUltimaDonacion: 11, diasSinDonar: 330, totalDonado: 8327),
        DonanteAltoValor(idDonante: 4, nombre: "Sebastian Castro", mesesUltimaDonacion: 2, diasSinDonar: 60, totalDonado: 7654)
    ])
    .padding()
    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
