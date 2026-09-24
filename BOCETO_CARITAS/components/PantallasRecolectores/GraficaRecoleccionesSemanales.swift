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
        RecoleccionesSemanales(numRecolecciones: 4, idDia: "Lunes"),
        RecoleccionesSemanales(numRecolecciones: 2, idDia: "Martes"),
        RecoleccionesSemanales(numRecolecciones: 3, idDia: "Miercoles"),
        RecoleccionesSemanales(numRecolecciones: 5, idDia: "Jueves"),
        RecoleccionesSemanales(numRecolecciones: 5, idDia: "Viernes"),
        RecoleccionesSemanales(numRecolecciones: 2, idDia: "Sabado"),
        RecoleccionesSemanales(numRecolecciones: 3, idDia: "Domingo")
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
