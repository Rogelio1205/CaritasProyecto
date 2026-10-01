//
//  AdminRecolectoresView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import SwiftUI

struct AdminRecolectoresView: View {
    var body: some View {
        VStack{
            Header()
            HStack {
                Spacer()
                Text("Recolecciones")
                    .font(.system(size: 75))
                    .bold()
                    .foregroundStyle(ColorConstants.mainColor)
                    .padding()
                    .padding(.trailing, 40)
            }
        }
    }
}

#Preview {
    AdminRecolectoresView()
}
