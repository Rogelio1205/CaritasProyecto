//
//  TopBar.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image("Caritas-Photoroom")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
            }
            Spacer()
            Image(systemName: "person.circle")
                .font(.system(size: 70))
                .foregroundColor(.black.opacity(0.7))
        }
        .padding(.bottom, 4)
    }
}

#Preview {
    TopBar()
}
