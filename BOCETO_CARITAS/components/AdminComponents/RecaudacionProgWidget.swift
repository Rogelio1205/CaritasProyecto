//
//  RecaudacionProgWidget.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import SwiftUI

struct RecaudacionProgWidget: View {
    var body: some View {
        VStack {
            BubbleWidget(backgroundColor: ColorConstants.mainColor, textColor: Color(.white), title: "ÉXITOSAS", value: "122", valueFontSize: 40, subtitle: "RECOLECTADAS")
                .frame(width:200)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    RecaudacionProgWidget()
}
