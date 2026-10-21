//
//  ResumenAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct ResumenAltoValor: View {

    let mejoresPorcentaje = 92
    let ultimaActividadDias = 22
    let totalRecaudado = 248038.0

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("DONANTES DE ALTO VALOR")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack(spacing: 16) {
                HStack(spacing: 16) {
                    StatCardTexto(
                        title: "MEJORES 10%",
                        value: mejoresPorcentaje,
                        subtitulo: "DONANTES",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)

                    StatCardTexto(
                        title: "ÚLTIMA ACTIVIDAD:",
                        value: ultimaActividadDias,
                        subtitulo: "DÍAS",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)

                TotalRecaudadoCard(monto: totalRecaudado)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct TotalRecaudadoCard: View {
    let monto: Double

    private var montoFormateado: String {
        let formato = NumberFormatter()
        formato.numberStyle = .decimal
        formato.groupingSeparator = ","
        formato.maximumFractionDigits = 0
        let numero = formato.string(from: NSNumber(value: monto)) ?? "\(Int(monto))"
        return "$\(numero)"
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text("TOTAL RECAUDADO")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))

            Text(montoFormateado)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color(red: 0.13, green: 0.34, blue: 0.38))

            Text("PESOS")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60).opacity(0.8))
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
    ResumenAltoValor()
        .padding()
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
