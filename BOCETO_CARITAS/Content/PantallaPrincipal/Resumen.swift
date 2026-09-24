//
//  Resumen.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct Resumen: View {
    let meta: Meta
    let riesgo: Riesgo

    private var llamadasHechas: Int { meta.llamadasHoy }
    private var llamadasMeta: Int { meta.metaDiaria }
    private var progreso: Double { meta.progreso }
    private var riesgoAlto: Int { riesgo.alto }
    private var riesgoMedio: Int { riesgo.medio }
    private var riesgoBajo: Int { riesgo.bajo }
    private var inactivos: Int { riesgo.inactivos }


    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 24) {
                Text("  META DIARIA")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundColor(.white)
                    .tracking(0.5)

                HStack(alignment: .bottom, spacing: 24) {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("\(llamadasHechas)")
                                .font(.system(size: 80, weight: .bold))
                                .foregroundColor(.white)
                            Text("/\(llamadasMeta)")
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundColor(.white.opacity(0.85))
                        }
                        Text("LLAMADAS")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white.opacity(0.85))
                            .tracking(0.5)
                    }

                    Spacer()

                    ZStack {
                        Circle()
                            .stroke(Color(red: 0.14, green: 0.38, blue: 0.44), lineWidth: 14)
                        Circle()
                            .trim(from: 0, to: progreso)
                            .stroke(
                                Color(red: 0.80, green: 0.93, blue: 0.95),
                                style: StrokeStyle(lineWidth: 14, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                        Text("\(Int(progreso * 100))%")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 110, height: 110)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color(red: 0.20, green: 0.53, blue: 0.60))
            )

            VStack(spacing: 16) {
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
                }
                HStack(spacing: 16) {
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
            .frame(maxWidth: .infinity)
        }
        .padding(20)
    }
}

struct StatCard: View {
    let titulo: String
    let cantidad: Int
    let colorTitulo: Color
    let colorNumero: Color
    let colorFondo: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(colorTitulo)
                .tracking(0.3)

            Text("\(cantidad)")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(colorNumero)

            Text("DONANTES")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(colorTitulo.opacity(0.85))
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

#Preview {
    Resumen(meta: Meta(llamadasHoy: 16, metaDiaria: 25),
            riesgo: Riesgo(alto: 12, medio: 17, bajo: 29, inactivos: 14))
        .frame(width: 900, height: 340)
}
