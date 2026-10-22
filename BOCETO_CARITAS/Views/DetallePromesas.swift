//
//  DetallePromesas.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 11/09/26.
//

import SwiftUI

struct DetallePromesas: View {
    @Environment(\.dismiss) private var dismiss

    let idPromesa: Int

    @State private var promesaActual: PromesaDetalle?
    @State private var estaCargado = true
    @State private var mensajeError: String?

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if estaCargado {
                        ProgressView("Cargando detalles de promesa...")
                            .controlSize(.large)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 80)
                    } else if let error = mensajeError {
                        ContentUnavailableView(
                            "No se pudo cargar la promesa",
                            systemImage: "exclamationmark.triangle",
                            description: Text(error)
                        )
                        .padding(.top, 40)
                    } else if let promesa = promesaActual {
                        HeaderCard(titulo: promesa.nombreCaso, subtitulo: "Promesa de pago")

                        StatusCard(
                            cantidad: promesa.monto,
                            estado: promesa.estadoNombre,
                            numeroCaso: promesa.idCaso,
                            FormaPago: promesa.formaPago,
                            FechaAlta: promesa.fechaCorta
                        )

                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                            GridRow {
                                StatCardDetalle(
                                    title: "Categoría",
                                    subtitulo: promesa.categorias.first ?? "N/A")
                                StatCardDetalle(
                                    title: "Tipo de frecuencia",
                                    subtitulo: promesa.tipoFrecuencia)
                            }
                            GridRow {
                                StatCardDetalle(
                                    title: "Línea estratégica",
                                    subtitulo: "N/A")
                                StatCardDetalle(
                                    title: "Asignación",
                                    subtitulo: "N/A")
                            }
                            GridRow {
                                StatCardDetalle(title: "Frecuencia", subtitulo: promesa.frecuencia)
                                    .gridCellColumns(2)   // ocupa todo el ancho
                            }
                        }
                    }
                }
                .padding(28)
            }

            // Botones fijos abajo: siempre visibles aunque el contenido haga scroll
            ButtonsSheet(
                onCancel: { dismiss() },
                onAccept: { dismiss() }
            )
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .background(.bar)
        }
        // Tamaño de la sheet en iPad (iOS 18+)
        .presentationSizing(.page)
        .presentationDragIndicator(.visible)
        .task {
            do {
                promesaActual = try await ObtenerPromesaDetalle(idPromesa: idPromesa)
            } catch {
                mensajeError = error.localizedDescription
                print("Error en task: \(error)")
            }
            estaCargado = false
        }
    }
}

struct ButtonsSheet: View {
    var onCancel: () -> Void
    var onAccept: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button {
                onCancel()
            } label: {
                Text("Cancelar")
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .buttonStyle(.bordered)
            .tint(.gray)

            Button {
                onAccept()
            } label: {
                Text("Aceptar")
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
            }
            .buttonStyle(.borderedProminent)
            .tint(ColorConstants.mainColor)
        }
        .buttonBorderShape(.capsule)
        .frame(maxWidth: 520)
        .frame(maxWidth: .infinity)
    }
}

struct HeaderCard: View {
    let titulo: String
    let subtitulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(subtitulo.uppercased())
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

struct StatusCard: View {
    let cantidad: Double
    let estado: String
    let numeroCaso: Int
    let FormaPago: String
    let FechaAlta: String

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CANTIDAD")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.secondary)
                    Text(cantidad.formatted(.currency(code: "MXN")))
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(ColorConstants.mainColor)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }

                Spacer(minLength: 16)

                VStack(alignment: .trailing, spacing: 4) {
                    Text("ESTADO")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.secondary)
                    Text(estado)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(estado == "Activa" ? ColorConstants.mainColor : .secondary)
                }
            }

            Divider()

            HStack(alignment: .top, spacing: 16) {
                DetailStack(label: "Número de caso", value: String(numeroCaso))
                DetailStack(label: "Forma de pago", value: FormaPago)
                DetailStack(label: "Fecha de alta", value: FechaAlta)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 120/255, green: 120/255, blue: 120/255, opacity: 0.12))
        )
    }
}

struct DetailStack: View {
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
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StatCardDetalle: View {
    let title: String
    let subtitulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.secondary)
            Text(subtitulo)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.primary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 120/255, green: 120/255, blue: 120/255, opacity: 0.12))
        )
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            DetallePromesas(idPromesa: 1)
        }
}
