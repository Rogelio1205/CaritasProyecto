//
//  TableRow.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 21/09/26.
//

import SwiftUI

struct TableRow: View {
    
    var field1 : String
    var field2 : String
    var field3 : String
    
    var body: some View {
        HStack() {
            Text(field1)
                .frame(maxWidth: .infinity)
            
            Text(field2)
                .frame(maxWidth: .infinity)
            
            Text(field3)
                .frame(maxWidth: .infinity)
                .foregroundStyle(ColorConstants.mainColor)
                .bold()
        }
        .font(.system(size: 20))
        .padding(.vertical, 12)
    }
}

#Preview {
    TableRow(field1: "Campaña Cáncer", field2: "Anual", field3: "$10,000")
}
