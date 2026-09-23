import SwiftUI

struct MultipleInfoField: View {
    
    var email: String
    var fechaNacimiento: String
    var edad: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Email")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(ColorConstants.mainColor)
                
                Text(email)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Fecha Nacimiento")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(ColorConstants.mainColor)
                
                Text(fechaNacimiento)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Edad")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundStyle(ColorConstants.mainColor)
                
                Text(edad)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(.primary)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(ColorConstants.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MultipleInfoField(email: "oramirez@gmail.com", fechaNacimiento: "22/12/2005", edad: "20")
}
