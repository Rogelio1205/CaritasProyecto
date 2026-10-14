//
//  SinConexionCard.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 09/10/26.
//

import SwiftUI

struct SinConexionCard: View {
    var body: some View {
        VStack (alignment: .center) { //Vstack principal
            Image(systemName: "wifi.slash")
                .font(.system(size:50))
                .foregroundStyle(ColorConstants.mainColor)
            
            Text("Sin conexion")
                .font(.system(size:45))
            
            Text("No se ha podido conectar con el servidor")
                .font(.system(size: 30))
            
        } // VStack principal        
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 35))
    }
}

#Preview {
    SinConexionCard()
}
