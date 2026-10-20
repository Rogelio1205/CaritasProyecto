//
//  RecoleccionesInfoTexts.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import SwiftUI

struct RecoleccionesInfoTexts: View {
    
    let datosRecoleccionesMes: RecoleccionesMes
    let totalPromesas: Int
    
    var body: some View {
        HStack{
            BubbleWidget(title: "TOTAL PROMESAS", value: "\(totalPromesas)", valueFontSize: 40, subtitle: "DEL MES")
                .padding(.horizontal, 10)
                .frame(height: 100)
            BubbleWidget(backgroundColor: ColorConstants.lightLowRisk, textColor: ColorConstants.lowRisk, title: "ÉXITOSAS", value: "\(datosRecoleccionesMes.exitosas)", valueFontSize: 40, subtitle: "RECOLECTADAS")
                .padding(.horizontal, 10)
                .frame(height: 100)
            BubbleWidget(backgroundColor: Color(red: 0.92, green: 0.90, blue: 0.83), textColor: Color(red: 0.53, green: 0.42, blue: 0.10), title: "PARCIALES", value: "\(datosRecoleccionesMes.parciales)", valueFontSize: 40, subtitle: "RECOLECTADAS")
                .padding(.horizontal, 10)
                .frame(height: 100)
            BubbleWidget(backgroundColor: ColorConstants.lightHighRisk, textColor: ColorConstants.highRisk, title: "NO RECOLECTADAS", value: "\(datosRecoleccionesMes.reprogramadas)", valueFontSize: 40, subtitle: "REPROGRAMADAS")
                .padding(.horizontal, 10)
                .frame(height: 100)
        }
    }
}

#Preview {
    let recMesPrueba = RecoleccionesMes(exitosas: 122, parciales: 32, reprogramadas: 26)
    let totalPromesasPrueba = 120
    RecoleccionesInfoTexts(datosRecoleccionesMes: recMesPrueba, totalPromesas: totalPromesasPrueba)
}
