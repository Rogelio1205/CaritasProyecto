import SwiftUI

struct DonanteDetallado: View {
    
    @State public var filterBy = 1
    @State public var id : Int
    @State private var donante : Donor?
    @State private var nombreCompleto : String?
    @State var colorRiesgo : Color?
    
    var body: some View {
        ZStack {
            ColorConstants.backgorund
            VStack (alignment: .leading) {
                Header().padding(.bottom, 42)
                
                HStack {
                    Spacer()
                    Text("DONANTE DETALLADO")
                        .font(.system(size: 36))
                        .foregroundStyle(ColorConstants.mainColor)
                        .bold()
                        .padding(.trailing, 41)
                        .padding(.bottom, 42)
                }
                
                VStack (alignment: .leading) {
                    Text(nombreCompleto?.uppercased() ?? "Sin nombre".uppercased())
                        .font(.system(size: 36))
                        .bold()
                        
                    
                    HStack {
                        BubbleWidget(
                            backgroundColor:  colorRiesgo?.opacity(0.1) ?? ColorConstants.highRisk.opacity(0.1),
                            textColor: colorRiesgo ?? ColorConstants.highRisk,
                            title: "NIVEL DE RIESGO",
                            value: donante?.nivelRiesgo.uppercased() ?? "INDEFINIDO",
                            valueFontSize: 32

                        )
                        
                        BubbleWidget(
                            title: "ÚLTIMA DONACIÓN:",
                            value: formatDate(donante?.ultimaDonacion ?? "SIN DONACIONES"),
                            valueFontSize: 32,
                            subtitle: timeAgo(donante?.ultimaDonacion ?? ""),
                            subtitleFontSize: 10
                        )
                        
                        BubbleWidget(
                            backgroundColor: ColorConstants.lightMainColor,
                            textColor: ColorConstants.mainColor,
                            title: "TOTAL DONADO:",
                            value: "$\(donante?.totalDonado ?? "0")",
                            valueFontSize: 32,
                            subtitle: "PESOS",
                            subtitleFontSize: 10
                        )
                        
                    }.frame(maxWidth: .infinity)
                        .frame(height: 92)
                        .padding(.bottom, 42)
                    
                    
                    HStack {
                        Spacer()
                        Picker(selection: $filterBy, label: Text("")) {
                            Text("GENERAL Y CONTACTO").tag(1)
                            Text("PROMESAS Y PAGO").tag(2)
                        }.pickerStyle(.segmented)
                            .padding(.bottom, 42)
                            .frame(width: 550)
                        Spacer()
                    }
                    
                    switch filterBy {
                    case 1:
                        GeneralInformation(telefonos: donante?.telefonos, informacion: donante?.informacionGeneral)
                    case 2:
                        PaymentsAndPromises(promesas: donante?.promesas, pagos: donante?.pagos)
                    default:
                        GeneralInformation(telefonos: donante?.telefonos, informacion: donante?.informacionGeneral)
                    }
                }.padding(.horizontal, 41)
                Spacer()
            }
        }.ignoresSafeArea()
        .task {
            do {
                donante = try await DonanteService.getDonante(id: id)
                
                if (donante?.nombre != nil || donante?.apellidoPaterno != nil) {
                    nombreCompleto = "\(donante?.nombre ?? "") \(donante?.apellidoPaterno ?? "") \(donante?.apellidoMaterno ?? "")"
                }
                                
                if (donante?.nivelRiesgo == "Bajo" || donante?.nivelRiesgo == "Sin historial") {
                    colorRiesgo = ColorConstants.lowRisk
                } else if (donante?.nivelRiesgo == "Medio") {
                    colorRiesgo = ColorConstants.midRisk
                } else {
                    colorRiesgo = ColorConstants.highRisk
                }
                
                
            } catch {
                print("Error obteniendo donante: \(error)")
            }
        }
    }
}

#Preview {
    DonanteDetallado(id: 1)
}
