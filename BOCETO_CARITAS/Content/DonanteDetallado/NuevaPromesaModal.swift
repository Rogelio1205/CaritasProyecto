//
//  NuevaPromesaModal.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct NuevaPromesaModal: View {
    @Binding var isPresented: Bool

    var campañasDisponibles: [String]

    var onGuardar: (PromesaPago) -> Void

    @State private var campaña = ""
    @State private var frecuencia = ""
    @State private var tipoFrecuencia = ""
    @State private var formaPago = ""
    @State private var asignacion = ""
    @State private var categoria = ""
    @State private var numeroCaso = ""
    @State private var lineaEstrategica = ""
    @State private var cantidadTexto = ""

    @State private var mostrarConfirmacion = false

    private let opcionesFrecuencia = ["ÚNICA", "PERMANENTE"]
    private let opcionesTipoFrecuencia = ["MENSUAL", "TRIMESTRAL", "SEMESTRAL", "ANUAL", "ÚNICA"]
    private let opcionesFormaPago = ["EFECTIVO", "TARJETA", "TRANSFERENCIA", "CHEQUE"]
    private let opcionesAsignacion = ["N/A", "GENERAL", "ESPECÍFICA"]
    private let opcionesCategoria = ["N/A", "ORDINARIO", "ESPECIAL"]
    private let opcionesLineaEstrategica = ["N/A", "SALUD", "EDUCACIÓN", "ALIMENTACIÓN"]

    private let colorAcento = Color(red: 0.20, green: 0.53, blue: 0.60)

    private var cantidadNumerica: Double {
        let limpio = cantidadTexto
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "$", with: "")
        return Double(limpio) ?? 0
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture { isPresented = false }

            VStack(alignment: .leading, spacing: 26) {
                Text("NUEVA PROMESA")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)

                let columnas = [
                    GridItem(.flexible(), alignment: .leading),
                    GridItem(.flexible(), alignment: .leading),
                    GridItem(.flexible(), alignment: .leading)
                ]

                LazyVGrid(columns: columnas, alignment: .leading, spacing: 24) {
                    DropdownCampo(titulo: "CAMPAÑA", seleccion: $campaña, opciones: campañasDisponibles, colorTitulo: colorAcento)
                    DropdownCampo(titulo: "FRECUENCIA", seleccion: $frecuencia, opciones: opcionesFrecuencia, colorTitulo: colorAcento)
                    DropdownCampo(titulo: "TIPO FRECUENCIA", seleccion: $tipoFrecuencia, opciones: opcionesTipoFrecuencia, colorTitulo: colorAcento)

                    DropdownCampo(titulo: "FORMA DE PAGO", seleccion: $formaPago, opciones: opcionesFormaPago, colorTitulo: colorAcento)
                    DropdownCampo(titulo: "ASIGNACIÓN", seleccion: $asignacion, opciones: opcionesAsignacion, colorTitulo: colorAcento)
                    DropdownCampo(titulo: "CATEGORÍA", seleccion: $categoria, opciones: opcionesCategoria, colorTitulo: colorAcento)

                    TextoCampo(titulo: "NÚMERO DE CASO", texto: $numeroCaso, colorTitulo: colorAcento)
                    DropdownCampo(titulo: "LÍNEA ESTRATÉGICA", seleccion: $lineaEstrategica, opciones: opcionesLineaEstrategica, colorTitulo: colorAcento)
                    TextoCampo(titulo: "CANTIDAD", texto: $cantidadTexto, colorTitulo: colorAcento, teclado: .decimalPad, prefix: "$")
                }

                HStack(spacing: 24) {
                    Spacer()

                    Button("CANCELAR") {
                        isPresented = false
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(colorAcento)

                    Button(action: guardar) {
                        Text("GUARDAR")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 26)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(colorAcento))
                    }
                }
            }
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
            )
            .padding(.horizontal, 24)

            if mostrarConfirmacion {
                ConfirmacionGuardadoView(colorAcento: colorAcento) {
                    mostrarConfirmacion = false
                    isPresented = false
                }
            }
        }
    }

    private func guardar() {
        let nueva = PromesaPago(
            campaña: campaña.isEmpty ? "N/A" : campaña,
            frecuenciaTexto: "FRECUENCIA: \(tipoFrecuencia.isEmpty ? "N/A" : tipoFrecuencia)",
            cantidad: cantidadNumerica,
            idPromesa: Int.random(in: 100...999),
            frecuencia: frecuencia.isEmpty ? "N/A" : frecuencia,
            tipoFrecuencia: tipoFrecuencia.isEmpty ? "N/A" : tipoFrecuencia,
            formaPago: formaPago.isEmpty ? "N/A" : formaPago,
            asignacion: asignacion.isEmpty ? "N/A" : asignacion,
            categoria: categoria.isEmpty ? "N/A" : categoria,
            numeroCaso: numeroCaso.isEmpty ? "N/A" : numeroCaso,
            lineaEstrategica: lineaEstrategica.isEmpty ? "N/A" : lineaEstrategica,
            fechaAlta: DateFormatter.fechaCorta.string(from: Date()),
            fechaCancelacion: "N/A",
            motivoCancelacion: "N/A"
        )
        onGuardar(nueva)
        withAnimation { mostrarConfirmacion = true }
    }
}

private struct DropdownCampo: View {
    let titulo: String
    @Binding var seleccion: String
    let opciones: [String]
    let colorTitulo: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(colorTitulo)

            Menu {
                ForEach(opciones, id: \.self) { opcion in
                    Button(opcion) { seleccion = opcion }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(seleccion.isEmpty ? "Label" : seleccion)
                        .font(.system(size: 15, weight: .semibold))
                        .lineLimit(1)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 11, weight: .semibold))
                }
                .foregroundColor(Color(red: 0.20, green: 0.47, blue: 0.90))
            }
        }
    }
}

private struct TextoCampo: View {
    let titulo: String
    @Binding var texto: String
    let colorTitulo: Color

    var teclado: UIKeyboardType = .default

    var prefix: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titulo)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(colorTitulo)

            HStack(spacing: 4) {
                if let prefix {
                    Text(prefix)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black.opacity(0.6))
                }
                TextField("", text: $texto)
                    .font(.system(size: 15, weight: .medium))
                    .keyboardType(teclado)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .frame(maxWidth: 180)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
            )
        }
    }
}


private struct ConfirmacionGuardadoView: View {
    let colorAcento: Color
    let onOK: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()

            VStack(spacing: 26) {
                Text("¡PROMESA GUARDADA!")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

                Button(action: onOK) {
                    Text("OK")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 34)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(colorAcento))
                }
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
            )
            .padding(.horizontal, 40)
        }
    }
}

extension DateFormatter {
    static let fechaCorta: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yy"
        return f
    }()
}

#Preview {
    NuevaPromesaModal(
        isPresented: .constant(true),
        campañasDisponibles: ["CAMPAÑA CÁNCER", "CAMPAÑA KARLA VALDÉZ", "CAMPAÑA HAMBRE CERO"],
        onGuardar: { _ in }
    )
}
