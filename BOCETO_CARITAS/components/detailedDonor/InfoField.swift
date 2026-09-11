import SwiftUI

struct InfoField: View {
    
    var title : String
    var value : String
    var icon : String
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .foregroundStyle(.white)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(.all, 8)
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundStyle(ColorConstants.mainColor)
                }
                VStack (alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.system(size: 15))
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                    Text(value)
                        .font(.system(size: 14))
                        .bold()
                }
                Spacer()
            }.background(ColorConstants.lightGray)
        }.clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    InfoField(title: "Casa", value: "81 8485 4792", icon: "house")
}
