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
            Text("")
        }
        .background(Color(.gray.opacity(0.2)))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    let recoleccionSigPrueba = RecoleccionSiguiente(nombreDonante: "Melanie Rivera", diasHastaSigDonacion: 10, cantDonacion: 10236)
    RecoleccionRow(recoleccionSig: recoleccionSigPrueba)
}
