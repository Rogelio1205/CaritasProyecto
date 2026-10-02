//
//  AdminInicio.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI

struct AdminInicio: View {
    var body: some View {
        VStack {
            Header()
            VStack {
                RecaudacionProgWidget(progress: 0.72)
            }.padding()
        }
    }
}

#Preview {
    AdminInicio()
}
