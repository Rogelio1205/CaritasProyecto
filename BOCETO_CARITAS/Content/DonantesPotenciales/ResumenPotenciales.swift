//
//  ResumenPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct ResumenPotenciales: View {
    let resumen: ResumenDonantesPotenciales

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Text("DONANTES POTENCIALES")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack(spacing: 16) {
                HStack(spacing: 16) {
                    StatCardTexto(
                        title: "DONANTES POTENCIALES",
                        value: resumen.donantesPotenciales,
                        subtitulo: "DONANTES",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)

                    StatCardTexto(
                        title: "DONANTES PRIORITARIOS",
                        value: resumen.donantesPrioritarios,
                        subtitulo: "DONANTES",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)

                PotencialRecaudacionCard(monto: resumen.potencialRecaudacion)
                    .frame(maxWidth: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct StatCardTexto: View {
    let title: String
    let value: Int
    let subtitulo: String
    let background: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))

            Text("\(value)")
                .font(.system(size: 44, weight: .bold))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))

            Text(subtitulo)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
        }
        .padding(18)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(background)
        )
    }
}

struct PotencialRecaudacionCard: View {
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
            Text("POTENCIAL DE RECAUDACIÓN")
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
    ResumenPotenciales(
        resumen: ResumenDonantesPotenciales(
            donantesPotenciales: 6,
            donantesPrioritarios: 1,
            potencialRecaudacion: 16500
        )
    )
    .padding()
    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
