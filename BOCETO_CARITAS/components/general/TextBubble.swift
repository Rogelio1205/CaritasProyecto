//
//  TextBubble.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 10/09/26.
//

import SwiftUI

struct TextBubble: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("RECOLECCIONES EN PROCESO")
                .font(.system(size: 25))
                .bold()
                .padding(.top, 15)
                .padding(.leading, 25)
                .padding(.trailing, 25)
            Text("5")
                .font(.system(size: 50))
                .bold()
                .padding(.leading, 25)
                .padding(.bottom, 15)
        }
        .background(Color(.gray.opacity(0.2)))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    TextBubble()
}
