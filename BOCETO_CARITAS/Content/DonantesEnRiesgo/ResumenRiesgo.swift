//
//  ResumenRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct ResumenRiesgo: View {

    let riesgoAlto = 12
    let riesgoMedio = 17
    let riesgoBajo = 29
    let inactivos = 14

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("DONANTES EN RIESGO")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack(spacing: 16) {
                StatCard(
                    titulo: "RIESGO ALTO",
                    cantidad: riesgoAlto,
                    colorTitulo: Color(red: 0.55, green: 0.15, blue: 0.15),
                    colorNumero: Color(red: 0.55, green: 0.15, blue: 0.15),
                    colorFondo: Color(red: 0.93, green: 0.87, blue: 0.87)
                )
                StatCard(
                    titulo: "RIESGO MEDIO",
                    cantidad: riesgoMedio,
                    colorTitulo: Color(red: 0.53, green: 0.42, blue: 0.10),
                    colorNumero: Color(red: 0.53, green: 0.42, blue: 0.10),
                    colorFondo: Color(red: 0.92, green: 0.90, blue: 0.83)
                )
                StatCard(
                    titulo: "RIESGO BAJO",
                    cantidad: riesgoBajo,
                    colorTitulo: Color(red: 0.14, green: 0.33, blue: 0.14),
                    colorNumero: Color(red: 0.14, green: 0.33, blue: 0.14),
                    colorFondo: Color(red: 0.87, green: 0.90, blue: 0.85)
                )
                StatCard(
                    titulo: "INACTIVOS",
                    cantidad: inactivos,
                    colorTitulo: Color(red: 0.25, green: 0.25, blue: 0.25),
                    colorNumero: Color(red: 0.15, green: 0.15, blue: 0.15),
                    colorFondo: Color(red: 0.88, green: 0.88, blue: 0.88)
                )
            }
        }
    }
}

#Preview {
    ResumenRiesgo()
        .padding()
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
}
