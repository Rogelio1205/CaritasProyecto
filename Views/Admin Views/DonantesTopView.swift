//
//  DonantesTopView.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 03/10/26.
//

import SwiftUI

struct DonantesTopView: View {
    //@State private var listaDonTop: [InfoDonantesTop]
    @State private var listaDonantesTop: Array<InfoDonantesTop> = [
        InfoDonantesTop(id: 1, nombreDonante: "Laura", apellidoDonante: "Fuentes", totalDonado: 18459, numDonaciones: 2, promedioDonado: 9320),
        InfoDonantesTop(id: 2, nombreDonante: "Carlos", apellidoDonante: "Méndez", totalDonado: 15200, numDonaciones: 4, promedioDonado: 3800),
        InfoDonantesTop(id: 3, nombreDonante: "Sofía", apellidoDonante: "Ramírez", totalDonado: 12750, numDonaciones: 3, promedioDonado: 4250),
        InfoDonantesTop(id: 4, nombreDonante: "Miguel", apellidoDonante: "Torres", totalDonado: 9800, numDonaciones: 5, promedioDonado: 1960),
        InfoDonantesTop(id: 5, nombreDonante: "Valeria", apellidoDonante: "Castillo", totalDonado: 7600, numDonaciones: 2, promedioDonado: 3800),
        InfoDonantesTop(id: 6, nombreDonante: "Diego", apellidoDonante: "Herrera", totalDonado: 5400, numDonaciones: 6, promedioDonado: 900),
        InfoDonantesTop(id: 7, nombreDonante: "Andrea", apellidoDonante: "Morales", totalDonado: 3150, numDonaciones: 3, promedioDonado: 1050)
    ]
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
                
                Text("TOP 10% VS RESTO DE DONANTES ")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .padding(.trailing,390)
                
                VStack(alignment: .leading) { //Vstack carta

                    Text("MONTO PROMEDIO DONADO POR DONANTE")
                        .font(.system(size: 25))
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
                    .padding(.top, 15)
                    
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
                    
                    Text("APORTACIÓN AL TOTAL RECAUDADO")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                        .padding(.top, 15)
                    
                    ProgressView(value: 62, total: 100)
                        .scaleEffect(x: 1, y: 6)
                        .padding(.bottom, 20)
                        .tint(ColorConstants.mainColor)
                    
                    HStack { //HStack puntos
                        HStack {
                            Circle()
                                .fill(ColorConstants.mainColor.opacity(0.5))
                                .frame(width: 10, height: 25)
                            
                            Text("Top 10% de donantes")
                                .fontWeight(.semibold)
                        }
                        
                        HStack {
                            Circle()
                                .fill(ColorConstants.mainColor.opacity(0.5))
                                .frame(width: 10, height: 25)
                            
                            Text("Resto de donantes")
                                .fontWeight(.semibold)
                        }
                        .padding(.leading, 35)
                        
                    } //HStack puntos
                    .padding(.bottom, 10)
                    
                } //Vstack Carta
                .padding(.top, 20)
                .padding( .horizontal, 30)
                .background(. white)
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .padding(.horizontal, 60)
                .padding(.top, 15)
                
                VStack {
                    Text("DONANTES TOP 10%")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .padding(.trailing, 510)
                        .padding(.bottom,-10)
                    
                    List(listaDonantesTop) { topitem in
                           DonantesTopRow(topDonantes: topitem)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.sidebar)
                    
                }
                .padding(.horizontal, 50)
                .padding(.top, 20)
                
                
                
                Spacer()
                
            } // VStack Principal
            
            
        } // ZStack Fondo
    }
}

#Preview {
    DonantesTopView()
}
