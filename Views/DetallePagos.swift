//
//  DetallePagos.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 23/09/26.
//

import SwiftUI

struct DetallePagosSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let idPago: Int
    
    @State private var pagoActual: PagoDetalle?
    @State private var isLoading: Bool = false
    @State private var mensajeError: String?
    
    var body: some View {
        ScrollView {
            VStack {
                if isLoading{
                    ProgressView("Cargando detalles de pago...")
                } else if let error = mensajeError{
                    Text("Error: \(error)")
                } else if let pago = pagoActual {
                    HeaderCardPago(titulo: pago.nombreCampana, subtitulo: "PAGOS")
                    PagoStatusCard(
                        monto: pago.montoDouble,
                        estatus: pago.estatusPago,
                        formaPago: pago.formaPago,
                        fechaConfirmacion: pago.fechaConfirmacion ?? "N/A",
                        cancelado: pago.cancelado
                    )
                    
                    VStack {
                        Grid {
                            GridRow {
                                StatCardPago(
                                    title: "Reprogramado",
                                    subtitulo: pago.reprogramado
                                )
                                StatCardPago(
                                    title: "Fecha Reprogramación",
                                    subtitulo: pago.fechaReprogramacion ?? "N/A"
                                )
                            }
                        }
                    }
                }
                
                BotonAceptarPago {
                    dismiss()
                }
                .padding(.top, 20)
            }
            .padding(30)
        }
        .frame(minWidth: 850, minHeight: 600)
        .task {
            do{
                pagoActual = try await obtenerPagoDetalle(idPago:idPago)
            } catch{
                print("Error: \(error)")
            }
        }
    }
}


struct HeaderCardPago: View {
    let titulo: String
    let subtitulo: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(titulo)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color.black)
                Text(subtitulo)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
}

struct PagoStatusCard: View {
    let monto: Double
    let estatus: String
    let formaPago: String
    let fechaConfirmacion: String
    let cancelado: String
    
    let mainColor = Color(red: 17/255, green: 153/255, blue: 170/255)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("MONTO")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.gray)
                    Text(monto.formatted(.currency(code: "MXN")))
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(mainColor)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text("ESTATUS PAGO")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.gray)
                    
                    Text(estatus)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(estatus == "Aprobado" ? mainColor : .gray)
                }
            }
            .padding(.trailing, 20)
            
            HStack(spacing: 40) {
                DetailStackPago(label: "Forma de pago", value: formaPago)
                DetailStackPago(label: "Fecha Confirmación", value: fechaConfirmacion)
                DetailStackPago(label: "Cancelado", value: cancelado)
            }
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 120/255, green: 120/255, blue: 120/255, opacity: 0.12))
        )
    }
}

struct DetailStackPago: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(Font.system(size: 16, weight: .bold))
                .foregroundStyle(Color.gray)
            Text(value)
                .font(Font.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.black)
        }
    }
}

struct StatCardPago: View {
    let title: String
    let subtitulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(red: 17/255, green: 153/255, blue: 170/255))

            Text(subtitulo)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color.black.opacity(0.85))
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 120/255, green: 120/255, blue: 120/255, opacity: 0.12))
        )
    }
}

struct BotonAceptarPago: View {
    var accion: () -> Void
    let mainColor = Color(red: 17/255, green: 153/255, blue: 170/255)
    
    var body: some View {
        Button(action: accion) {
            Text("ACEPTAR")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(mainColor)
                .cornerRadius(25)
        }
        .padding(20)
    }
}

#Preview {
    DetallePagosSheet(idPago: 1)
}
