//
//  DonantesAltoValor.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesAltoValor: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ScrollView{
                TopBar()
                ResumenAltoValor()
                    .padding(10)
                FiltroDonantesAltoValor()
                    .padding(.vertical, 30)
            }
        }
    }
}

#Preview {
    DonantesEnRiesgo()
}
