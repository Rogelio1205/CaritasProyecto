import SwiftUI

struct DonanteDetallado: View {
    
    @State public var filterBy = 1
    
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
                    Text("OSCAR RAMÍREZ CRUZ")
                        .font(.system(size: 36))
                        .bold()
                    
                    HStack {
                        BubbleWidget(
                            backgroundColor: ColorConstants.lightHighRisk,
                            textColor: ColorConstants.highRisk,
                            title: "NIVEL DE RIESGO",
                            value: "RIESGO ALTO",
                            valueFontSize: 32

                        )
                        
                        BubbleWidget(
                            title: "ÚLTIMA DONACIÓN:",
                            value: "SEP 21 2024",
                            valueFontSize: 32,
                            subtitle: "HACE 2 AÑOS",
                            subtitleFontSize: 10
                        )
                        
                        BubbleWidget(
                            backgroundColor: ColorConstants.lightMainColor,
                            textColor: ColorConstants.mainColor,
                            title: "TOTAL DONADO:",
                            value: "$22,736",
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
                        GeneralInformation()
                    case 2:
                        PaymentsAndPromises()
                    default:
                        GeneralInformation()
                    }
                }.padding(.horizontal, 41)
                Spacer()
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    DonanteDetallado()
}
