//
//  RecoleccionRow.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 10/09/26.
//

import SwiftUI

struct RecoleccionRow: View {
    
    @State public var recoleccionSig: RecoleccionSiguiente
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("\(recoleccionSig.nombreDonante)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    Text("Recolecciones en \(recoleccionSig.diasHastaSigDonacion) días")
                        .font(.system(size: 20))
                }
                .padding(.trailing, 50)
                VStack {
                    Text("Donación")
                        .font(.system(size: 20))
                    Text("$\(recoleccionSig.cantDonacion)")
                        .font(.title)
                        .bold()
                }
                Spacer()
            }
        }
        .padding()
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    let recoleccionSigPrueba = RecoleccionSiguiente(nombreDonante: "Melanie Rivera", diasHastaSigDonacion: 10, cantDonacion: 10236)
    RecoleccionRow(recoleccionSig: recoleccionSigPrueba)
}
