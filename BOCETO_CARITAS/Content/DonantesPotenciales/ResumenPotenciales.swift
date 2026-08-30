//
//  ResumenPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct ResumenPotenciales: View {

    let donantesPotenciales = 24
    let casosSimilares = 17
    let potencialRecaudacion = 83529.0

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("DONANTES POTENCIALES")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack(spacing: 16) {
                HStack(spacing: 16) {
                    StatCard(
                        titulo: "DONANTES POTENCIALES",
                        cantidad: donantesPotenciales,
                        colorTitulo: Color(red: 0.25, green: 0.25, blue: 0.25),
                        colorNumero: .black,
                        colorFondo: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)

                    StatCardTexto(
                        title: "CASOS   SIMILARES:",
                        value: casosSimilares,
                        subtitulo: "CASOS",
                        background: Color(red: 0.88, green: 0.88, blue: 0.88)
                    )
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)

                PotencialRecaudacionCard(monto: potencialRecaudacion)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct StatCardTexto: View {
    let title: String
    let value: Int
    let subtitulo: String
    let background: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))

            Text("\(value)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)

            Text(subtitulo)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25).opacity(0.85))
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
            Text("POTENCIAL DE RECAUDACIÓN:")
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
    ResumenPotenciales()
        .padding()
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
