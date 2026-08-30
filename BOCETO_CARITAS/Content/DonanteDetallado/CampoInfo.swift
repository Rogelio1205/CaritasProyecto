//
//  CampoInfo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct CampoInfo: View {
    let titulo: String
    let valor: String
    var colorTitulo: Color = Color(red: 0.13, green: 0.34, blue: 0.38)

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titulo)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(colorTitulo)
            Text(valor)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.black)
        }
    }
}
