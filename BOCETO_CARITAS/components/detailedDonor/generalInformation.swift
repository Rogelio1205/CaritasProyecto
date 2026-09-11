import SwiftUI

struct GeneralInformation: View {
    var body: some View {
        InfoBox(title: "CANALES DE CONTACTO", icon: "phone.fill", content: {
            HStack (spacing: 16){
                VStack {
                    InfoField(title: "CASA", value: "81 84845 4792", icon: "house")
                    InfoField(title: "OFICINA", value: "81 5739 5693", icon: "briefcase")
                }
                VStack {
                    InfoField(title: "MÓVIL", value: "81 5728 2767", icon: "iphone")
                    InfoField(title: "TEMPORAL", value: "81 1067 2864", icon: "clock")
                }
            }.padding()
        }).frame(height: 222)
            .padding(.bottom, 47)
        
        InfoBox(title: "INFORMACIÓN GENERAL", icon: "message.fill", content: {
            Rectangle().foregroundStyle(.white)
        }).frame(height: 222)
    }
}

#Preview {
    GeneralInformation()
}
