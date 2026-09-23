import SwiftUI

struct PaymentsAndPromises: View {
    
    let promesas : [Promesa]?
    
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
                            TableRow(field1: "Campaña Cáncer", field2: "12/08/26", field3: "$10,236")
                            Divider()
                            TableRow(field1: "Campaña Karla Valdéz", field2: "22/12/25", field3: "$10,000")
                            Divider()
                            TableRow(field1: "Campaña Hambre Cero", field2: "28/04/25", field3: "$2,500")
                            Divider()
                        }
                    }

                
            }).frame(height: 270)
        }
    }
}

#Preview {
    PaymentsAndPromises(promesas: [])
}
