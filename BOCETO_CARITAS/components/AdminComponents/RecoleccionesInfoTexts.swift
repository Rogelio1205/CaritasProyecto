//
//  RecoleccionesInfoTexts.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import SwiftUI

struct RecoleccionesInfoTexts: View {
    var body: some View {
        HStack{
            BubbleWidget(title: "TOTAL PROMESAS", value: "180", valueFontSize: 40, subtitle: "DEL MES")
                .frame(width:200)
            BubbleWidget(backgroundColor: ColorConstants.lightLowRisk, textColor: ColorConstants.lowRisk, title: "ÉXITOSAS", value: "122", valueFontSize: 40, subtitle: "RECOLECTADAS")
                .frame(width:200)
                .padding(.horizontal, 20)
            BubbleWidget(backgroundColor: Color(red: 0.92, green: 0.90, blue: 0.83), textColor: Color(red: 0.53, green: 0.42, blue: 0.10), title: "PARCIALES", value: "122", valueFontSize: 40, subtitle: "RECOLECTADAS")
                .frame(width:200)
            BubbleWidget(backgroundColor: ColorConstants.lightHighRisk, textColor: ColorConstants.highRisk, title: "NO RECOLECTADAS", value: "26", valueFontSize: 40, subtitle: "REPROGRAMADAS")
                .frame(width:200)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    RecoleccionesInfoTexts()
}
