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
            
            VStack(alignment: .leading) { // VStack de nombre y dinero
                Text("\(caso.nombre)")
                    .font(.system(size: 25))
                    .padding(.bottom, 5)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    //.minimumScaleFactor(0.8)
                    .frame(width: 250, alignment: .leading)
                
                var totalPagadoSinFormat = caso.totalPagado
                var montoSolSinFormtat = caso.montoSolicitado
                
                var totalPagadoFormatted = totalPagadoSinFormat.formatted(.number.precision(.fractionLength(0)))
                var montoSolFormatted = montoSolSinFormtat.formatted(.number.precision(.fractionLength(0)))
                
                Text("$\(totalPagadoFormatted) / $\(montoSolFormatted)")
                    .font(.system(size: 19))
                    .padding(.bottom, 20)
                    .fontWeight(.semibold)
                    //.minimumScaleFactor(0.8)
                    //.frame(width: 190, alignment: .trailing)
                    .lineLimit(1)
            } // VSTack nombre y dinero
            .frame(width: 200, alignment: .leading)
            
            ProgressView(value: caso.totalPagado, total: caso.montoSolicitado)
                .scaleEffect(x: 1, y: 6)
                .padding(.bottom, 20)
                .padding(.horizontal, 30)
                .padding(.leading, 30)
                .tint(ColorConstants.mainColor)
                .frame(minWidth: 50)
            
            /*var totalPagadoSinFormat = caso.totalPagado
            var montoSolSinFormtat = caso.montoSolicitado
            
            var totalPagadoFormatted = totalPagadoSinFormat.formatted(.number.precision(.fractionLength(0)))
            var montoSolFormatted = montoSolSinFormtat.formatted(.number.precision(.fractionLength(0)))
            
            Text("$\(totalPagadoFormatted) / $\(montoSolFormatted)")
                .font(.system(size: 19))
                .padding(.bottom, 20)
                .fontWeight(.semibold)
                //.minimumScaleFactor(0.8)
                .frame(width: 190, alignment: .trailing) */
        } // HSTACK Grafica 1
    }
}

#Preview {
    let graficaPrueba = RecaudadoArea(idCaso: 1, nombre: "Campaña Hambre Cero", totalPagado: 500, montoSolicitado: 1000)
    Graficas(caso: graficaPrueba)
}
