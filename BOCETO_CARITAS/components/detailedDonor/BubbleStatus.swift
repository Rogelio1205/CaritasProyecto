import SwiftUI

struct BubbleStatus: View {
    
    let title : String
    let status : Bool
    
    let falseColor = Color(red: 124/255, green: 28/255, blue: 14/255)
    let trueColor = Color(red: 166/255, green: 237/255, blue: 134/255)
    let trueDarkColor = Color(red: 32/255, green: 73/255, blue: 13/255)
    
    init(
         title : String,
         status : Bool = false
    ) {
        self.title = title;
        self.status = status
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: status ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(status ? trueDarkColor : falseColor)
                Text(title)
                    .font(.system(size: 20))
                    .bold()
                    .padding(.bottom, 3)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
        .padding(15)
        .background(status ? trueColor.opacity(0.3) : falseColor.opacity(0.1))
        .foregroundStyle(status ? trueDarkColor : falseColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        ColorConstants.backgorund
        BubbleStatus(
            title: "Estado",
            status: false
        )
    }
}
