//
//  MostrarPromesaPago.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct MostrarPromesaPago: View {
    let promesa: PromesaPago
    @State private var expandido = false

    private var cantidadFormateada: String {
        let formato = NumberFormatter()
        formato.numberStyle = .decimal
        formato.groupingSeparator = ","
        formato.maximumFractionDigits = 0
        let n = formato.string(from: NSNumber(value: promesa.cantidad)) ?? "\(Int(promesa.cantidad))"
        return "$\(n) PESOS"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(promesa.campaña)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                    Text(promesa.frecuenciaTexto)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("CANTIDAD")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.gray)
                    Text(cantidadFormateada)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                }

                Button {
                    withAnimation { expandido.toggle() }
                } label: {
                    Image(systemName: expandido ? "chevron.down" : "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray.opacity(0.6))
                }
            }

            if expandido {
                let columnas = [
                    GridItem(.flexible(), alignment: .leading),
                    GridItem(.flexible(), alignment: .leading),
                    GridItem(.flexible(), alignment: .leading)
                ]
                LazyVGrid(columns: columnas, alignment: .leading, spacing: 16) {
                    CampoInfo(titulo: "ID", valor: "\(promesa.idPromesa)", colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FRECUENCIA", valor: promesa.frecuencia, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "TIPO FRECUENCIA", valor: promesa.tipoFrecuencia, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FORMA DE PAGO", valor: promesa.formaPago, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "ASIGNACIÓN", valor: promesa.asignacion, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "CATEGORÍA", valor: promesa.categoria, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "NÚMERO DE CASO", valor: promesa.numeroCaso, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "LÍNEA ESTRATÉGICA", valor: promesa.lineaEstrategica, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FECHA ALTA", valor: promesa.fechaAlta, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FECHA CANCELACIÓN", valor: promesa.fechaCancelacion, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "MOTIVO CANCELACIÓN", valor: promesa.motivoCancelacion, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                }
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
        )
    }
}
