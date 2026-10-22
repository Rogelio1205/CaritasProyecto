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
    @State private var isLoading: Bool = true
    @State private var mensajeError: String?

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if isLoading {
                        ProgressView("Cargando detalles de pago...")
                            .controlSize(.large)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 80)
                    } else if let error = mensajeError {
                        ContentUnavailableView(
                            "No se pudo cargar el pago",
                            systemImage: "exclamationmark.triangle",
                            description: Text(error)
                        )
                        .padding(.top, 40)
                    } else if let pago = pagoActual {
                        HeaderCardPago(titulo: pago.nombreCampana, subtitulo: "PAGOS")

                        PagoStatusCard(
                            monto: pago.montoDouble,
                            estatus: pago.estatusPago,
                            formaPago: pago.formaPago,
                            fechaConfirmacion: pago.fechaConfirmacion.map { formatDate($0) } ?? "N/A",
                            cancelado: pago.cancelado
                        )

                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                            GridRow {
                                StatCardPago(
                                    title: "Reprogramado",
                                    subtitulo: pago.reprogramado
                                )
                                StatCardPago(
                                    title: "Fecha de reprogramación",
                                    subtitulo: pago.fechaReprogramacion.map { formatDate($0) } ?? "N/A"
                                )
                            }
                        }
                    }
                }
                .padding(28)
            }

            // Botón fijo abajo: siempre visible aunque el contenido haga scroll
            BotonAceptarPago {
                dismiss()
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(.bar)
        }
        // Tamaño de la sheet en iPad (iOS 18+)
        .presentationSizing(.page)
        .presentationDragIndicator(.visible)
        .task {
            do {
                pagoActual = try await obtenerPagoDetalle(idPago: idPago)
            } catch {
                mensajeError = error.localizedDescription
                print("Error: \(error)")
            }
            isLoading = false
        }
    }
}


struct HeaderCardPago: View {
    let titulo: String
    let subtitulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(subtitulo)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.secondary)
            Text(titulo)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("MONTO")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.secondary)
                    Text(monto.formatted(.currency(code: "MXN")))
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(mainColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }

                Spacer(minLength: 16)

                VStack(alignment: .trailing, spacing: 4) {
                    Text("ESTATUS")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.secondary)
                    Text(estatus)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(estatus == "Aprobado" ? mainColor : .secondary)
                }
            }

            Divider()

            HStack(alignment: .top, spacing: 16) {
                DetailStackPago(label: "Forma de pago", value: formaPago)
                DetailStackPago(label: "Fecha de confirmación", value: fechaConfirmacion)
                DetailStackPago(label: "Cancelado", value: cancelado)
            }
        }
        .padding(24)
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
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.system(size: 18))
        }
        // Las 3 columnas se reparten el ancho por igual y el texto hace salto de línea
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StatCardPago: View {
    let title: String
    let subtitulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.secondary)
            Text(subtitulo)
                .font(.system(size: 20))
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
                .font(.system(size: 20, weight: .bold))
                .frame(maxWidth: 320)
                .frame(height: 50)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(mainColor)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            DetallePagosSheet(idPago: 1)
        }
}
