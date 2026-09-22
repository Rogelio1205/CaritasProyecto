import SwiftUI

struct TableHead: View {
    
    var column1 : String
    var column2 : String
    var column3 : String
    
    var body: some View {
        HStack() {
            Text("Campaña")
                .frame(maxWidth: .infinity)

            Text("Frecuencia")
                .frame(maxWidth: .infinity)

            Text("Monto")
                .frame(maxWidth: .infinity)
        }
        .font(.system(size: 20))
        .bold()
        .padding(.vertical, 12)
        .background(ColorConstants.lightGray)
    }
}

#Preview {
    TableHead(column1: "Campaña", column2: "Frecuencia", column3: "Monto")
}
