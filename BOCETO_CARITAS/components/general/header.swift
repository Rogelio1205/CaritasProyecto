import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            HStack {
                Image("Caritas-Photoroom")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                Spacer()
                Image(systemName: "person.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.horizontal, 40)
        }
        .background {
            Rectangle()
                .fill(.white)
                .shadow(radius: 5, y: 10)
        }
    }
}

#Preview {
    Header()
}
