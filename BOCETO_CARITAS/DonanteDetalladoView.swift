//
//  DonanteDetalladoView.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//


import SwiftUI

struct DonanteDetalladoView: View {
    let donante: DonanteDetalladoInfo

    @State private var promesas: [PromesaPago]
    @State private var mostrarNuevaPromesa = false

    init(donante: DonanteDetalladoInfo) {
        self.donante = donante
        self._promesas = State(initialValue: donante.promesas)
    }

    private var campañasDisponibles: [String] {
        let nombres = (promesas.map(\.campaña) + donante.bitacora.map(\.campaña))
        return Array(Set(nombres)).sorted()
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("DONANTE DETALLADO")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    VStack(alignment: .leading, spacing: 10) {
                        Text(donante.nombreCompleto)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)

                        HStack(spacing: 10) {
                            Text("ÚLTIMA DONACIÓN: \(donante.ultimaDonacionFecha)")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.gray)

                            if let etiqueta = donante.etiquetaRiesgo {
                                Text(etiqueta)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(donante.colorRiesgo)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(
                                        Capsule().fill(donante.colorRiesgo.opacity(0.15))
                                    )
                            }
                        }

                        ContactoPills(donante: donante)
                    }

                    Text("INFORMACIÓN DEL DONANTE")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)

                    InformacionDonanteCard(donante: donante)

                    HStack {
                        Text("PROMESAS DE PAGO")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: { mostrarNuevaPromesa = true }) {
                            Text("AGREGAR PROMESA")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Color(red: 0.20, green: 0.53, blue: 0.60))
                        }
                    }

                    VStack(spacing: 12) {
                        ForEach(promesas) { promesa in
                            MostrarPromesaPago(promesa: promesa)
                        }
                    }

                    Text("BITÁCORA DE PAGOS")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)

                    VStack(spacing: 12) {
                        ForEach(donante.bitacora) { pago in
                            MostrarPagoBitacora(pago: pago)
                        }
                    }

                    Color.clear.frame(height: 40)
                }
                .padding(20)
            }
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .navigationBarTitleDisplayMode(.inline)

            if mostrarNuevaPromesa {
                NuevaPromesaModal(
                    isPresented: $mostrarNuevaPromesa,
                    campañasDisponibles: campañasDisponibles,
                    onGuardar: { nuevaPromesa in
                        promesas.append(nuevaPromesa)
                    }
                )
            }
        }
    }
}

private struct ContactoPills: View {
    let donante: DonanteDetalladoInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                ContactoPill(icono: "house.fill", texto: donante.telefonoCasa)
                ContactoPill(icono: "briefcase.fill", texto: donante.telefonoOficina)
                ContactoPill(icono: "iphone", texto: donante.telefonoCelular)
                ContactoPill(icono: "clock.fill", texto: donante.telefonoOtro)
            }
            ContactoPill(icono: "envelope.fill", texto: donante.email)
        }
    }
}

private struct ContactoPill: View {
    let icono: String
    let texto: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icono)
                .font(.system(size: 12))
            Text(texto)
                .font(.system(size: 13, weight: .semibold))
        }
        .foregroundColor(.black.opacity(0.75))
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule().fill(Color(red: 0.90, green: 0.90, blue: 0.90))
        )
    }
}

private struct InformacionDonanteCard: View {
    let donante: DonanteDetalladoInfo

    var body: some View {
        let columnas = [
            GridItem(.flexible(), alignment: .leading),
            GridItem(.flexible(), alignment: .leading),
            GridItem(.flexible(), alignment: .leading)
        ]

        LazyVGrid(columns: columnas, alignment: .leading, spacing: 18) {
            CampoInfo(titulo: "TIPO DE DONANTE", valor: donante.tipoDonante)
            CampoInfo(titulo: "CLASIFICACIÓN", valor: donante.clasificacion)
            CampoInfo(titulo: "DONANTE ESPECIAL", valor: donante.donanteEspecial)
            CampoInfo(titulo: "ESTATUS", valor: donante.estatus)
            CampoInfo(titulo: "EXCLUIDO", valor: donante.excluido)
            CampoInfo(titulo: "FECHA EXCLUSIÓN", valor: donante.fechaExclusion)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.68, green: 0.82, blue: 0.82))
        )
    }
}

#Preview {
    NavigationStack {
        DonanteDetalladoView(
            donante: .DonanteInformacion(
                nombre: "Oscar Ramírez Cruz",
                etiquetaRiesgo: "RIESGO ALTO",
                colorRiesgo: Color(red: 0.55, green: 0.15, blue: 0.15)
            )
        )
    }
}
