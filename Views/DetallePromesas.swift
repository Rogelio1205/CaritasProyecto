//
//  DetallePromesas.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 11/09/26.
//

import SwiftUI

struct DetallePromesas: View {
    @Environment(\.dismiss) private var dismiss
    
    // Parámetro para saber qué promesa buscar
    let idPromesa: Int
    
    @State private var promesaActual: PromesaDetalle?
    @State private var estaCargado = true
    @State private var mensajeError: String?
    
    var body: some View {
        // 2. Envolvemos en un ScrollView por si el sheet es más pequeño que el contenido
        ScrollView {
            VStack {
                if estaCargado {
                    ProgressView("Cargando detalles de promesa ...")
                        .scaleEffect(1.5)
                        .padding(.top, 50)
                } else if let error = mensajeError {
                    Text("Error: \(error)")
                        .foregroundColor(Color.black)
                        .padding(.top, 50)
                } else if let promesa = promesaActual {
                    VStack {
                        HeaderCard(titulo: promesa.nombreCaso, subtitulo: "Promesa de pago")
                        
                        StatusCard(cantidad: promesa.monto, isActive: false, numeroCaso: promesa.idCaso, FormaPago: promesa.formaPago, FechaAlta: promesa.fechaCorta)
                        
                        VStack {
                            Grid() {
                                GridRow {
                                    StatCardDetalle(
                                        title: "Categoria",
                                        subtitulo: promesa.categorias.first ?? "N/A")
                                    StatCardDetalle(
                                        title: "Tipo frecuencia",
                                        subtitulo: promesa.tipoFrecuencia)
                                }
                                GridRow {
                                    StatCardDetalle(
                                        title: "Linea Estrategica",
                                        subtitulo: "N/A")
                                    StatCardDetalle(
                                        title: "Asignacion",
                                        subtitulo: "N/A")
                                }
                                GridRow {
                                    StatCardDetalle(title: "Frecuencia", subtitulo: promesa.frecuencia)
                                }
                            }
                        }
                    }
                }
                
                // 3. Pasamos las acciones a los botones
                ButtonsSheet(
                    onCancel: { dismiss() },
                    onAccept: {
                        // Aquí puedes poner lógica de guardado antes de cerrar
                        dismiss()
                    }
                )
                .padding(.top, 20)
            }
            
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // 4. Eliminamos el .frame fijo y el .background original para que fluya nativo
        }
        .frame(minWidth: 850, minHeight: 600)
        .task {
            do {
                // Usamos el ID dinámico en lugar del 1 hardcodeado
                promesaActual = try await ObtenerPromesaDetalle(idPromesa: idPromesa)
                estaCargado = false
            } catch {
                mensajeError = error.localizedDescription
                estaCargado = false
                print("Error en task: \(error)")
            }
        }
    }
}

// MARK: - Botones Actualizados para recibir acciones
struct ButtonsSheet: View {
    var onCancel: () -> Void
    var onAccept: () -> Void
    
    var body: some View {
        HStack {
            Button("Cancelar") {
                onCancel()
            }
            .buttonStyle(.borderedProminent)
            .font(.system(size: 30, weight: .semibold))
            .frame(height: 50)
            .tint(Color.gray)
            
            Spacer()
            
            Button("Aceptar") {
                onAccept()
            }
            .buttonStyle(.borderedProminent)
            .font(.system(size: 30, weight: .semibold))
            .frame(height: 50)
            .tint(ColorConstants.mainColor) // Asegúrate de tener tu ColorConstants en el proyecto
        }
        .frame(width: 500)
        .padding(10)
    }
}

struct HeaderCard: View {
    let titulo: String
    let subtitulo: String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(titulo)
                    .font(.system(size:30, weight: .bold))
                    .foregroundStyle(Color.black)
                Text(subtitulo)
                    .font(.system(size:14, weight: .medium))
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.top, 30)
        .padding(.horizontal, 10)
    }
}

struct StatusCard: View {
    let cantidad: Double
    let isActive: Bool
    let numeroCaso: Int
    let FormaPago: String
    let FechaAlta: String
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text("Cantidad")
                        .font(.system(size: 18, weight: .semibold))
                    Text(cantidad.formatted(.currency(code: "MXN")))
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(ColorConstants.mainColor)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5){
                    Text("Estado")
                        .font(.system(size: 16, weight: .bold))
                    HStack(spacing: 8){
                        Text("Activa")
                        Toggle("", isOn: .constant(isActive))
                            .frame(width: 50)
                            .labelsHidden()
                    }
                }
            }
            .padding(.trailing, 300)
            HStack(spacing: 30){
                DetailStack(label: "Numero de caso", value: String(numeroCaso))
                DetailStack(label: "Forma de pago", value: FormaPago)
                DetailStack(label: "Fecha de alta", value: FechaAlta)
            }
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red:120/255, green: 120/255, blue: 120/255, opacity: 0.12)))
    }
}

struct DetailStack: View {
    let label: String
    let value: String
    var body: some View{
        VStack(alignment: .leading){
            Text(label)
                .font(Font.system(size: 20, weight: .bold))
            Text(value)
                .font(Font.system(size: 18))
        }
    }
}

struct StatCardDetalle: View {
    let title: String
    let subtitulo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color.black)

            Text(subtitulo)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25).opacity(0.85))
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red:120/255, green: 120/255, blue: 120/255, opacity: 0.12))
        )
    }
}

struct Buttons: View{
    var body: some View{
        HStack{
            Button("Cancelar"){
                
            }.buttonStyle(.borderedProminent)
                .font(.system(size: 30, weight: .semibold))
                .frame(height: 50)
                .tint(Color.gray)
            Spacer()
            Button("Aceptar"){
                
            }.buttonStyle(.borderedProminent)
                .font(.system(size: 30, weight: .semibold))
                .frame(height: 50)
                .tint(ColorConstants.mainColor)
        } .frame(width: 500)
            .padding(10)
    }
}

#Preview {
    DetallePromesas(idPromesa: 1)
}
