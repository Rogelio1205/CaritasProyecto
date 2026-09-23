import SwiftUI

struct PaymentsAndPromises: View {
    
    let promesas : [Promesa]?
    let pagos : [Pago]?
    
    var body: some View {
        VStack (){
            InfoBox(title: "PROMESAS DE PAGO", icon: "checkmark", content: {
                TableHead(column1: "Campaña", column2: "Frecuencia", column3: "Monto")
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(promesas ?? [], id: \.id) { promesa in
                            TableRow(
                                field1: promesa.caso,
                                field2: promesa.frecuencia,
                                field3: "$\(promesa.monto)"
                            )
                            Divider()
                        }
                    }
                }
                
            }).frame(height: 270)
                .padding(.bottom, 47)
            
            InfoBox(title: "BITÁCORA DE PAGOS", icon: "dollarsign", content: {
                TableHead(column1: "Campaña", column2: "Fecha", column3: "Monto")
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(pagos ?? [], id: \.id) { pago in
                            TableRow(
                                field1: String(pago.id),
                                field2: formatDate(pago.fecha),
                                field3: "$\(pago.importe)"
                            )
                            Divider()
                        }
                    }
                }
            }).frame(height: 270)
        }
    }
}

#Preview {
    PaymentsAndPromises(promesas: [], pagos: [])
}
