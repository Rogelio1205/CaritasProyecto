//
//  DonantesRiesgo.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesEnRiesgo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ScrollView{
                TopBar()
                ResumenRiesgo()
                    .padding(10)
                FiltroDonantesRiesgo()
                    .padding(.vertical, 30)
            }
        }
    }
}

#Preview {
    DonantesEnRiesgo()
}
