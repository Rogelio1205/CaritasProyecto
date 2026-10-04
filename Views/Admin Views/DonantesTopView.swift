//
//  DonantesTopView.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 03/10/26.
//

import SwiftUI

struct DonantesTopView: View {
    var body: some View {
        ZStack { // ZStack Fondo
            Color(red:244/255, green:244/255, blue:244/255)
                .ignoresSafeArea()
            VStack { // VStack Principal
                Header()
                Text("Donantes TOP 10%")
                    .padding(.top, 30)
                    .padding(.leading, 475)
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    .foregroundStyle(ColorConstants.mainColor)
                
                HStack { //HStack bubble widgets
                    BubbleWidget(textColor: Color(red:66/255,green:66/255, blue: 66/255),title: "MEJORES 10%", titleFontSize: 14 , value: "92", valueFontSize: 40, subtitle: "DONANTES", subtitleFontSize: 13)
                        .frame(width:250)
                    
                    BubbleWidget(textColor: Color(red:66/255,green:66/255, blue: 66/255), title: "PROMEDIO RESTO", titleFontSize: 14, value: "$840", valueFontSize: 40, subtitle: "PESOS POR DONANTE", subtitleFontSize: 13)
                        .frame(width:300)
                        .padding(.horizontal, 20)
                    
                    BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "PROMEDIO TOP 10%", titleFontSize: 14, value: "$6,420", valueFontSize: 40, subtitle: "PESOS POR DONANTE", subtitleFontSize: 13)
                        .frame(width:300)
                } // HSTAck bubble widgets
                .frame(height: 119)
                .padding( .horizontal)
                
                VStack(alignment: .leading) { //Vstack carta
                    Text("TOP 10% VS RESTO DE DONANTES ")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    HStack { // HSTAck grafica top 10%
                        Text("Top 10%")
                            .font(.system(size: 25))
                            .padding(.bottom, 20)
                            .fontWeight(.semibold)
                        
                        ProgressView(value: 78, total: 100)
                            .scaleEffect(x: 1, y: 6)
                            .padding(.bottom, 20)
                            .padding(.leading, 115)
                            .padding(.trailing, 50)
                            .tint(ColorConstants.mainColor)
                        
                        Text("$6,420")
                            .font(.system(size: 20))
                            .padding(.bottom, 20)
                            .fontWeight(.semibold)
                    } //Hstack grafica top 10%
                    .padding(.top, 5)
                    
                    HStack { // HSTAck resto 90%
                        Text("Resto (90%)")
                            .font(.system(size: 25))
                            .padding(.bottom, 20)
                            .fontWeight(.semibold)
                        
                        ProgressView(value: 20, total: 100)
                            .scaleEffect(x: 1, y: 6)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 70)
                            .tint(ColorConstants.mainColor)
                        
                        Text("$840")
                            .font(.system(size: 20))
                            .padding(.bottom, 20)
                            .fontWeight(.semibold)
                    } //Hstack resto 90%
                    .padding(.top, 5)
                    
                } //Vstack Carta
                .padding(.top, 20)
                .padding( .horizontal, 30)
                .background(. purple)
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .padding(.horizontal, 60)
                .padding(.top, 35)
                
                
                
                Spacer()
                
            } // VStack Principal
            
            
        } // ZStack Fondo
    }
}

#Preview {
    DonantesTopView()
}
