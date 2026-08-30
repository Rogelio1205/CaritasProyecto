//
//  DonantesPotenciales.swift
//  BOCETO_CARITAS
//
//  Created by Rogelio Iram González Ortiz on 29/08/26.
//

import SwiftUI

struct DonantesPotenciales: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ScrollView{
                
                TopBar()
                ResumenPotenciales()
                    .padding(10)
                FiltroDonantesPotenciales()
                    .padding(.vertical, 30)
            }
        }
    }
}

#Preview {
    DonantesPotenciales()
}
