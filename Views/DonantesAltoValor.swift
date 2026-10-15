import SwiftUI

struct DonantesAltoValorVista: View {
    @StateObject private var viewModel = DonanteAltoValorViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Header().padding(.bottom, 42).padding(.top,-30)

            if let donanteAltoValor = viewModel.data {
                ResumenAltoValorPantalla(resumen: donanteAltoValor.resumen).padding(.horizontal,16)

                FiltroDonantesAltoValor(donantes: donanteAltoValor.donantesAltoValor)
                    .padding(.vertical, 30).padding(.horizontal,16)
            }
            else if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .task {
            await viewModel.cargar()
        }
    }
}

#Preview {
    DonantesAltoValorVista()
}
