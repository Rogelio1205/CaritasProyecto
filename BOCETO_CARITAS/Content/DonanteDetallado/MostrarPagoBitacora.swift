//
//  MostrarPagoBitacora.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct MostrarPagoBitacora: View {
    let pago: PagoBitacora
    @State private var expandido = false

    private var montoFormateado: String {
        let formato = NumberFormatter()
        formato.numberStyle = .decimal
        formato.groupingSeparator = ","
        formato.maximumFractionDigits = 0
        let n = formato.string(from: NSNumber(value: pago.monto)) ?? "\(Int(pago.monto))"
        return "$\(n) PESOS"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(pago.campaña)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                    Text("REALIZADA EL: \(pago.fechaRealizada)")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("MONTO")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.gray)
                    Text(montoFormateado)
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
                    CampoInfo(titulo: "STATUS PAGO", valor: pago.statusPago, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FORMA PAGO", valor: pago.formaPago, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FECHA CONF.", valor: pago.fechaConfirmacion, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "MOTIVO REPROGRAMACIÓN", valor: pago.motivoReprogramacion, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "FECHA REPROGRAMACIÓN", valor: pago.fechaReprogramacion, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
                    CampoInfo(titulo: "COMENTARIOS", valor: pago.comentarios, colorTitulo: Color(red: 0.20, green: 0.53, blue: 0.60))
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

