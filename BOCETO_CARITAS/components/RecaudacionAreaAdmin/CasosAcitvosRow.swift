//
//  CasosAcitvosRow.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI

struct CasosAcitvosRow: View {
    var body: some View {
        VStack{ // VSTACK principal
            HStack{ // HSTACK
                VStack(alignment: .leading) { // VSTACK CAMP y DES
                    Text("Campaña Cancer ")
                        .font(.title)
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    Text("Apoyo a Tratamientos oncologicos")
                        .foregroundStyle(Color(red: 164/255, green: 164/255, blue: 164/255))
                } // VSTACK CAMP y DES
                
                Spacer()
                
                VStack {
                    Text("Recaudado")
                    Text("$36,750 pesos")
                }
                
                
                
            } // HSTACK
            .padding(.leading, 70)
            .padding(.trailing, 50)
            .padding(.vertical, 10)
            
        } // VSTACK principal
        .background(.gray.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CasosAcitvosRow()
}
