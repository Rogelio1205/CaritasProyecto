import SwiftUI

struct PaymentsAndPromises: View {
    var body: some View {
        VStack {
            InfoBox(title: "PROMESAS DE PAGO", icon: "checkmark", content: {
                Rectangle().foregroundStyle(.white)
            }).frame(height: 222)
                .padding(.bottom, 47)
            
            InfoBox(title: "BITÁCORA DE PAGOS", icon: "dollarsign", content: {
                Rectangle().foregroundStyle(.white)
            }).frame(height: 222)
        }
    }
}

#Preview {
    PaymentsAndPromises()
}
