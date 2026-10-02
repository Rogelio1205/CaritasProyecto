//
//  CasosAcitvosRow.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI

struct CasosAcitvosRow: View {
    
    @State var casosAct: CasosActivos
    
    var body: some View {
        VStack{ // VSTACK principal
            HStack{ // HSTACK
                VStack(alignment: .leading) { // VSTACK CAMP y DES
                    Text("\(casosAct.nombre)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    Text("\(casosAct.descripcion)")
                        .foregroundStyle(Color(red: 164/255, green: 164/255, blue: 164/255))
                } // VSTACK CAMP y DES
                
                Spacer()
                
                VStack {
                    var numSinFormato = casosAct.totalPagado
                    var numFormateado = numSinFormato.formatted(.number.precision(.fractionLength(0)))
                    Text("Recaudado")
                    Text("$\(numFormateado) pesos")
                }
                
                
                
            } // HSTACK
            .padding(.leading, 10)
            .padding(.trailing, 50)
            .padding(.vertical, 10)
            
        } // VSTACK principal
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    let casosPrueba = CasosActivos(idCaso: 1, nombre: "Campaña Cancer", descripcion: "Apoyo a tratamientos oncologicos", totalPagado: 48200)
    CasosAcitvosRow(casosAct: casosPrueba)
}
