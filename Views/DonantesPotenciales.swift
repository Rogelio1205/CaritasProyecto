//
//  DonantesPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesPotenciales: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                TopBar()
                ResumenPotenciales()
                    .padding(10)
                FiltroDonantesPotenciales()
                    .padding(.vertical, 30)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
    }
}

#Preview {
    DonantesPotenciales()
}
