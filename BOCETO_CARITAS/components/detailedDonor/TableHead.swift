import SwiftUI

struct TableHead: View {
    
    var column1 : String
    var column2 : String
    var column3 : String
    
    var body: some View {
        HStack() {
            Text(column1)
                .frame(maxWidth: .infinity)

            Text(column2)
                .frame(maxWidth: .infinity)

            Text(column3)
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
