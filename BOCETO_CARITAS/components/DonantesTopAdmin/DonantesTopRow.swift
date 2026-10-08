//
//  DonantesTopRow.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 05/10/26.
//

import SwiftUI

struct DonantesTopRow: View {
    
    let topDonantes: InfoDonantesTop
    
    var body: some View {
        VStack{ // VSTACK principal
            HStack{ // HSTACK
                VStack(alignment: .leading) { // VSTACK CAMP y DES
                    Text("\(topDonantes.nombre) \(topDonantes.apellidoPaterno)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    HStack {
                        var numSinFormato = topDonantes.totalDonado
                        
                         var numFormateado = numSinFormato.formatted(.number.precision(.fractionLength(0)))
                        Text("Total donado: $\(numFormateado)")
                            .foregroundStyle(Color(red: 164/255, green: 164/255, blue: 164/255))
                        
                        Text("· \(topDonantes.numDonaciones) donaciones")
                            .foregroundStyle(Color(red: 164/255, green: 164/255, blue: 164/255))
                    }
                } // VSTACK CAMP y DES
                
                Spacer()
                
                VStack {
                    var numSinFormato = topDonantes.totalDonado
                    var numFormateado = numSinFormato.formatted(.number.precision(.fractionLength(0)))
                    Text("Monto Promedio")
                    Text("$\(numFormateado) pesos")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
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
    let listaPrueba = InfoDonantesTop(id: 1, nombre: "Laura", apellidoPaterno: "Fuentes", totalDonado: 18459, numDonaciones: 2, montoPromedio: 9320)
    DonantesTopRow(topDonantes: listaPrueba)
}
