import SwiftUI

struct DonantesAltoValor: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                TopBar()
                ResumenAltoValor()
                    .padding(10)
                FiltroDonantesAltoValor()
                    .padding(.vertical, 30)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
    }
}

#Preview {
    DonantesAltoValor()
}
