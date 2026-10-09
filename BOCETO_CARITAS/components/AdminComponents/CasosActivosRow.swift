//
//  CasosActivosRow.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 05/10/26.
//

import SwiftUI

struct CasosActivosRow: View {
    @State public var casoActivo: CasosActivos
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(casoActivo.nombreCampaña)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    Text("\(casoActivo.descripcion)")
                        .font(.system(size: 25))
                }
                Spacer()
                VStack {
                    Text("RECAUDADO / META")
                        .font(.system(size: 25))
                    HStack {
                        Text("\(casoActivo.recaudado)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(ColorConstants.mainColor)
                        Text(" / \(casoActivo.meta)")
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
        }
        .padding()
        .cornerRadius(20)
        .background(Color(.white))
        .cornerRadius(20)
        .padding(.horizontal, 30)
        .padding(.bottom)
    }
}

#Preview {
    let casoActivoPrueba = CasosActivos(nombreCampaña: "Campaña Cáncer", descripcion: "Apoyo a tratamientos", recaudado: 48200, meta: 60000)
    CasosActivosRow(casoActivo: casoActivoPrueba)
}
