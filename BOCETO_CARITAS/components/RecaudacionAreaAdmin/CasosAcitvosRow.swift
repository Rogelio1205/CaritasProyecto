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
                    Text("\(casosAct.nombreCampaña)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    Text("\(casosAct.descripcion)")
                        .foregroundStyle(Color(red: 164/255, green: 164/255, blue: 164/255))
                } // VSTACK CAMP y DES
                
                Spacer()
                
                VStack {
                    Text("Recaudado")
                    Text("$\(casosAct.sumaCampaña) pesos")
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
    let casosPrueba = CasosActivos(id: 1, nombreCampaña: "Campaña Cancer", descripcion: "Apoyo a tratamientos oncologicos", sumaCampaña: "48,200")
    CasosAcitvosRow(casosAct: casosPrueba)
}
