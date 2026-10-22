import SwiftUI

struct GeneralInformation: View {
    
    let telefonos : Telefonos?
    let informacion : InformacionGeneral?
    
    private var fechaNacimientoDate: Date? {
        guard let texto = informacion?.fechaNacimiento else { return nil }
        let formato = DateFormatter()
        formato.locale = Locale(identifier: "en_US_POSIX")
        formato.timeZone = TimeZone(secondsFromGMT: 0)
        formato.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return formato.date(from: texto)
    }
    
    private var fechaNacimientoTexto: String {
        guard let nacimiento = fechaNacimientoDate else { return "N/A" }
        let salida = DateFormatter()
        salida.locale = Locale(identifier: "es_MX")
        salida.timeZone = TimeZone(secondsFromGMT: 0)
        salida.dateFormat = "dd/MM/yyyy"
        return salida.string(from: nacimiento)
    }
    
    private var edadTexto: String {
        guard let nacimiento = fechaNacimientoDate else { return "N/A" }
        var calendario = Calendar(identifier: .gregorian)
        calendario.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        guard let anios = calendario.dateComponents([.year], from: nacimiento, to: Date()).year else { return "N/A" }
        return String(anios)
    }
    
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
                        BubbleStatus(title: "Donante Especial", status: informacion?.donanteEspecial ?? false)
                        BubbleStatus(title: "Excluido", status: informacion?.excluido ?? false)
                        BubbleStatus(title: "Activo", status: true)
                    }
                    .frame(maxWidth: .infinity)
                    
                    MultipleInfoField(email: informacion?.correo ?? "N/A", fechaNacimiento: fechaNacimientoTexto, edad: edadTexto)
                    
                    VStack {
                        InfoField(title: "Clasificación", value: informacion?.clasificacion ?? "N/A")
                        InfoField(title: "Fecha Exclusión", value: informacion?.fechaExclusion ?? "N/A")
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
    GeneralInformation(telefonos: Telefonos(casa: "81 8485 4792", movil: "81 8485 4793", temporal: "81 8485 4794", trabajo: "81 8485 4795"), informacion: InformacionGeneral(clasificacion: "", correo: "oscarramirez@gmail.com", donanteEspecial: false, excluido: false, fechaExclusion: "", fechaNacimiento: "Wed, 14 Mar 1979 00:00:00 GMT", tipoDonante: "Físico"))
}
