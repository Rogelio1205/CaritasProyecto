//
//  ResumenRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct RiesgoCard: View {
    let titulo: String
    let cantidad: Int
    let colorTitulo: Color
    let colorNumero: Color
    let colorFondo: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(colorTitulo)
                .tracking(0.3)

            Text("\(cantidad)")
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(colorNumero)

            Text("DONANTES")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(colorTitulo)
                .tracking(0.3)
        }
        .padding(18)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(colorFondo)
        )
    }
}

struct ResumenRiesgo: View {

    let riesgo: Riesgo

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("DONANTES EN RIESGO")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack(spacing: 16) {
                RiesgoCard(
                    titulo: "RIESGO ALTO",
                    cantidad: riesgo.alto,
                    colorTitulo: Color(red: 0.55, green: 0.15, blue: 0.15),
                    colorNumero: Color(red: 0.55, green: 0.15, blue: 0.15),
                    colorFondo: Color(red: 0.93, green: 0.87, blue: 0.87)
                )
                RiesgoCard(
                    titulo: "RIESGO MEDIO",
                    cantidad: riesgo.medio,
                    colorTitulo: Color(red: 0.53, green: 0.42, blue: 0.10),
                    colorNumero: Color(red: 0.53, green: 0.42, blue: 0.10),
                    colorFondo: Color(red: 0.92, green: 0.90, blue: 0.83)
                )
                RiesgoCard(
                    titulo: "RIESGO BAJO",
                    cantidad: riesgo.bajo,
                    colorTitulo: Color(red: 0.14, green: 0.33, blue: 0.14),
                    colorNumero: Color(red: 0.14, green: 0.33, blue: 0.14),
                    colorFondo: Color(red: 0.87, green: 0.90, blue: 0.85)
                )
                RiesgoCard(
                    titulo: "INACTIVOS",
                    cantidad: riesgo.inactivos,
                    colorTitulo: Color(red: 0.25, green: 0.25, blue: 0.25),
                    colorNumero: Color(red: 0.15, green: 0.15, blue: 0.15),
                    colorFondo: Color(red: 0.88, green: 0.88, blue: 0.88)
                )
            }
        }
    }
}

#Preview {
    ResumenRiesgo(riesgo: Riesgo(alto: 5, medio: 4, bajo: 7, inactivos: 1))
        .padding()
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
