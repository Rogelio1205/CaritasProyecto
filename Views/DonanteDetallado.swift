import SwiftUI

struct DonanteDetallado: View {
    
    
    var body: some View {
        ZStack {
            Color(red: 244/255, green: 244/255, blue: 244/255)
            VStack {
                Header().padding(.bottom, 42)
                
                HStack {
                    Spacer()
                    Text("DONANTE DETALLADO")
                        .font(.system(size: 36))
                        .foregroundStyle(ColorConstants.mainColor)
                        .bold()
                        .padding(.trailing, 41)
                }
                VStack{
                    
                }.padding(.horizontal, 41)
            }
        }
    }
}

#Preview {
    DonanteDetallado()
}
