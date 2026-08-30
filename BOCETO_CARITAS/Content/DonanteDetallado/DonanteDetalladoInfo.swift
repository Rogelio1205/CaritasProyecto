//
//  DonanteDetalladoInfo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonanteDetalladoInfo: Identifiable, Hashable {
    let id = UUID()

    let nombreCompleto: String
    let ultimaDonacionFecha: String
    let etiquetaRiesgo: String?
    let colorRiesgo: Color

    let telefonoCasa: String
    let telefonoOficina: String
    let telefonoCelular: String
    let telefonoOtro: String
    let email: String

    let tipoDonante: String
    let clasificacion: String
    let donanteEspecial: String
    let estatus: String
    let excluido: String
    let fechaExclusion: String

    let promesas: [PromesaPago]
    let bitacora: [PagoBitacora]
}

extension DonanteDetalladoInfo {

    static func DonanteInformacion(
        nombre: String,
        ultimaDonacionFecha: String = "25/08/24",
        etiquetaRiesgo: String? = nil,
        colorRiesgo: Color = Color(red: 0.55, green: 0.15, blue: 0.15),
        telefono: String = "81 8485 4792"
    ) -> DonanteDetalladoInfo {

        let correo = nombre
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .replacingOccurrences(of: " ", with: "")

        return DonanteDetalladoInfo(
            nombreCompleto: nombre.uppercased(),
            ultimaDonacionFecha: ultimaDonacionFecha,
            etiquetaRiesgo: etiquetaRiesgo,
            colorRiesgo: colorRiesgo,
            telefonoCasa: telefono,
            telefonoOficina: telefono,
            telefonoCelular: telefono,
            telefonoOtro: telefono,
            email: "\(correo)@gmail.com",
            tipoDonante: "FÍSICO",
            clasificacion: "ORDINARIO",
            donanteEspecial: "FÍSICO",
            estatus: "ORDINARIO",
            excluido: "NO",
            fechaExclusion: "N/A",
            promesas: [
                PromesaPago(
                    campaña: "CAMPAÑA CÁNCER",
                    frecuenciaTexto: "FRECUENCIA: ANUAL",
                    cantidad: 10000,
                    idPromesa: 12,
                    frecuencia: "PERMANENTE",
                    tipoFrecuencia: "ANUAL",
                    formaPago: "EFECTIVO",
                    asignacion: "N/A",
                    categoria: "N/A",
                    numeroCaso: "173957",
                    lineaEstrategica: "N/A",
                    fechaAlta: "31/04/24",
                    fechaCancelacion: "N/A",
                    motivoCancelacion: "N/A"
                ),
                PromesaPago(
                    campaña: "CAMPAÑA KARLA VALDÉZ",
                    frecuenciaTexto: "FRECUENCIA: ÚNICA",
                    cantidad: 1000,
                    idPromesa: 13,
                    frecuencia: "ÚNICA",
                    tipoFrecuencia: "ÚNICA",
                    formaPago: "TARJETA",
                    asignacion: "N/A",
                    categoria: "N/A",
                    numeroCaso: "173958",
                    lineaEstrategica: "N/A",
                    fechaAlta: "10/02/24",
                    fechaCancelacion: "N/A",
                    motivoCancelacion: "N/A"
                ),
                PromesaPago(
                    campaña: "CAMPAÑA HAMBRE CERO",
                    frecuenciaTexto: "FRECUENCIA: TRIMESTRAL",
                    cantidad: 2500,
                    idPromesa: 12,
                    frecuencia: "PERMANENTE",
                    tipoFrecuencia: "TRIMESTRAL",
                    formaPago: "EFECTIVO",
                    asignacion: "N/A",
                    categoria: "N/A",
                    numeroCaso: "173957",
                    lineaEstrategica: "N/A",
                    fechaAlta: "31/04/24",
                    fechaCancelacion: "N/A",
                    motivoCancelacion: "N/A"
                )
            ],
            bitacora: [
                PagoBitacora(
                    campaña: "CAMPAÑA CÁRCEL",
                    fechaRealizada: "12/08/2026",
                    monto: 10236,
                    statusPago: "COMPLETADO",
                    formaPago: "EFECTIVO",
                    fechaConfirmacion: "12/08/2026",
                    motivoReprogramacion: "N/A",
                    fechaReprogramacion: "N/A",
                    comentarios: "N/A"
                ),
                PagoBitacora(
                    campaña: "CAMPAÑA KARLA VALDÉZ",
                    fechaRealizada: "22/12/2025",
                    monto: 10000,
                    statusPago: "COMPLETADO",
                    formaPago: "TARJETA",
                    fechaConfirmacion: "22/12/2025",
                    motivoReprogramacion: "N/A",
                    fechaReprogramacion: "N/A",
                    comentarios: "N/A"
                ),
                PagoBitacora(
                    campaña: "CAMPAÑA HAMBRE CERO",
                    fechaRealizada: "28/04/2026",
                    monto: 2500,
                    statusPago: "COMPLETADO",
                    formaPago: "EFECTIVO",
                    fechaConfirmacion: "28/04/2026",
                    motivoReprogramacion: "N/A",
                    fechaReprogramacion: "23/09/26",
                    comentarios: "N/A"
                )
            ]
        )
    }
}
