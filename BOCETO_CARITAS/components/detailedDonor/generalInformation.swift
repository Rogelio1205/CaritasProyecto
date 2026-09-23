import SwiftUI

struct GeneralInformation: View {
    
    let telefonos : Telefonos?
    
    var body: some View {
        InfoBox(title: "CANALES DE CONTACTO", icon: "phone.fill", content: {
            HStack (spacing: 16){
                VStack {
                    InfoField(title: "CASA", value: telefonos?.casa ?? "N/A", icon: "house")
                    InfoField(title: "OFICINA", value: telefonos?.trabajo ?? "N/A", icon: "briefcase")
                }
                VStack {
                    InfoField(title: "MÓVIL", value: telefonos?.movil ?? "N/A", icon: "iphone")
                    InfoField(title: "TEMPORAL", value: telefonos?.temporal ?? "N/A", icon: "clock")
                }
            }.padding()
        }).frame(height: 270)
            .padding(.bottom, 47)
        
        InfoBox(
            title: "INFORMACIÓN GENERAL",
            icon: "message.fill",
            content: {
                HStack(spacing: 20) {
                    
                    // Columna 1
                    VStack {
                        BubbleStatus(title: "Donante Especial", status: false)
                        BubbleStatus(title: "Excluido", status: false)
                        BubbleStatus(title: "Activo", status: true)
                    }
                    .frame(maxWidth: .infinity)
                    
                    MultipleInfoField(email: "oramirez@gmail.com", fechaNacimiento: "22/12/2005", edad: "20")
                    
                    VStack {
                        InfoField(title: "Clasificación", value: "Ordinario")
                        InfoField(title: "Fecha Exclusión", value: "N/A")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding()
            }
        )
        .frame(height: 270)

    }
}

#Preview {
    GeneralInformation(telefonos: Telefonos(casa: "81 8485 4792", movil: "81 8485 4793", temporal: "81 8485 4794", trabajo: "81 8485 4795"))
}
