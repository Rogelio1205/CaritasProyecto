//
//  ResumenAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

import SwiftUI

struct ResumenAltoValorPantalla: View {
    let resumen: ResumenDonantesAltoValor

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Text("DONANTES DE ALTO VALOR")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack(spacing: 16) {
                HStack(spacing: 16) {
                    StatCardTexto(
                        title: "MEJORES 10%",
                        value: resumen.donantesAltoValor,
                        subtitulo: "DONANTES",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)

                    StatCardTexto(
                        title: "ÚLTIMA ACTIVIDAD",
                        value: resumen.ultimaActividadDias,
                        subtitulo: "DÍAS",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)

                TotalRecaudadoCard(monto: resumen.totalRecaudado)
                    .frame(maxWidth: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct TotalRecaudadoCard: View {
    let monto: Int

    private var montoFormateado: String {
        let formato = NumberFormatter()
        formato.numberStyle = .decimal
        formato.groupingSeparator = ","
        formato.maximumFractionDigits = 0
        let numero = formato.string(from: NSNumber(value: monto)) ?? "\(monto)"
        return "$\(numero)"
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text("TOTAL RECAUDADO")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

            Text(montoFormateado)
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .minimumScaleFactor(0.5)
                .lineLimit(1)

            Text("PESOS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
        }
        .padding(18)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 0.87, green: 0.93, blue: 0.93))
        )
    }
}

#Preview {
    ResumenAltoValorPantalla(
        resumen: ResumenDonantesAltoValor(
            donantesAltoValor: 92,
            totalRecaudado: 248038,
            ultimaActividadDias: 22
        )
    )
    .padding()
    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
