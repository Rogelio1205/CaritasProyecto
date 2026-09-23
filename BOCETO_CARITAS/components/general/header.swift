import SwiftUI

struct Header: View {
    @State private var logout = false
    var body: some View {
        NavigationStack {
            HStack {
                HStack {
                    Image("Caritas-Photoroom")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 160)
                    Spacer()
                    // Generar un log out con este icono
                    /*Image(systemName: "person.circle")
                     .font(.system(size: 60))
                     .foregroundColor(.black.opacity(0.7))
                     */
                    
                    // Borrar despues de la presentacion
                    Button{
                        logout = true
                    }
                    label: {
                        Text("Log out")
                            .frame(maxWidth: 100)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .frame(maxWidth: 100)
                    .padding(.top, 30)
                    .tint(Color(red:0, green: 152/255, blue: 174/255))
                    .font(.system(size: 20))
                }
                .padding(.horizontal, 40)
            }
            .background {
                Rectangle()
                    .fill(.white)
                    .shadow(radius: 5, y: 10)
            }
        }
        .navigationDestination(isPresented: $logout)
        {
            LoginView()
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    Header()
}
