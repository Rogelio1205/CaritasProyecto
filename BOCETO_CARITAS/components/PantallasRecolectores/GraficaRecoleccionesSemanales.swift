//
//  GraficaRecoleccionesSemanales.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 10/09/26.
//

import SwiftUI
import Charts

struct GraficaRecoleccionesSemanales: View {
    let listaRecoleccionesSemanales = [
        RecoleccionesSemanales(numRecolecciones: 4, idDia: 1),
        RecoleccionesSemanales(numRecolecciones: 2, idDia: 2),
        RecoleccionesSemanales(numRecolecciones: 3, idDia: 3),
        RecoleccionesSemanales(numRecolecciones: 5, idDia: 4),
        RecoleccionesSemanales(numRecolecciones: 5, idDia: 5),
        RecoleccionesSemanales(numRecolecciones: 2, idDia: 6),
        RecoleccionesSemanales(numRecolecciones: 3, idDia: 7)
    ]
    var body: some View {
        VStack {
            Chart(listaRecoleccionesSemanales){ item in
                BarMark(
                    x: .value("Escenario", item.idDia),
                    y: .value("Número de asistentes", item.numRecolecciones)
                ).foregroundStyle(ColorConstants.mainColor)
            }
        }
    }
}

#Preview {
    GraficaRecoleccionesSemanales()
}
