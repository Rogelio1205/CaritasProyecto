//
//  Graficas.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import SwiftUI
import Charts

struct Graficas: View {
    let caso: RecaudadoArea
    var body: some View {
        HStack { // HSTACK Grafica 1
            
            Text("Campña Cancer")
                .font(.system(size: 25))
                .padding(.bottom, 20)
                .fontWeight(.semibold)
                .lineLimit(1)
            
            ProgressView(value: 78, total: 100)
                .scaleEffect(x: 1, y: 6)
                .padding(.bottom, 20)
                .padding(.horizontal, 30)
                .tint(ColorConstants.mainColor)
            
            Text("$48,200 / $60,000")
                .font(.system(size: 20))
                .padding(.bottom, 20)
                .fontWeight(.semibold)
        } // HSTACK Grafica 1
    }
}

#Preview {
    let graficaPrueba = RecaudadoArea(idCaso: 1, nombre: "Campaña Cancer", totalPagado: 500, montoSolicitado: 1000)
    Graficas(caso: graficaPrueba)
}
