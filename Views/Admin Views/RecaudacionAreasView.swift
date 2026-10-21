//
//  RecaudacionAreasView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI
import Charts

struct RecaudacionAreasView: View {
    var body: some View {
        ZStack { //ZStack
            
            Color(red:244/255, green:244/255, blue:244/255)
                .ignoresSafeArea()
            
            //ScrollView {
                
                VStack{ // VStack principal
                    Header()
                    Text("RECAUDACIÓN POR ÁREAS")
                        .padding(.top, 50)
                        .padding(.leading, 250)
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color(red:0, green: 152/255, blue: 174/255))
                    
                    HStack {
                        
                        BubbleWidget(title: "AREAS ACTIVAS", value: "6", valueFontSize: 40, subtitle: "AREAS")
                            .frame(width:200)
                        
                        BubbleWidget(backgroundColor: Color(red: 124/255, green: 28/255, blue: 14/255).opacity(0.1), textColor: Color(red: 124/255, green: 28/255, blue: 14/255), title: "POR RECAUDAR", value: "$72, 480", valueFontSize: 40, subtitle: "PESOS")
                            .frame(width:300)
                            .padding(.horizontal, 20)
                        BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "TOTAL RECAUDADO", value: "$186, 420", valueFontSize: 40, subtitle: "PESOS")
                            .frame(width:300)
                        
                    }
                    .frame(height: 119)
                    .padding( .horizontal)
                    
                    VStack(alignment: .leading) { // VSTACK Carta Graficas
                        Text("RECAUDADO VS META POR AREA")
                            .font(.system(size: 30))
                        
                        HStack { // HSTACK Grafica 1
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(Color(red: 0/255, green: 113/255, blue: 130/255))
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                        } // HSTACK Grafica 1
                        .padding( .top, 15)
                        
                        HStack { // HSTACK Grafica 2
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(Color(red: 0/255, green: 113/255, blue: 130/255))
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                        } // HSTACK Grafica 2
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 3
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(Color(red: 0/255, green: 113/255, blue: 130/255))
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                        } // HSTACK Grafica 3
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 4
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(Color(red: 0/255, green: 113/255, blue: 130/255))
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                        } // HSTACK Grafica 4
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 5
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(Color(red: 0/255, green: 113/255, blue: 130/255))
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                        } // HSTACK Grafica 5
                        .padding( .top, 5)
                        
                    } // VSTACK Carta Graficas
                    .padding(.top, 20)
                    .padding( .horizontal, 30)
                    .background(. gray)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding(.horizontal, 60)
                    .padding(.top, 35)
                    
                    
                    
                    VStack(alignment: .leading){
                        Text("CASOS ACTIVOS")
                            .font(.system(size: 38))
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        VStack{
                            //foreach(CasosAcitvosRow) { casoitem in}
                        }
                    }
                    .padding(.trailing, 580)
                    . background(.purple)
                    .padding( .top, 20)
                    
                    Spacer()
                    
                } // Vstack Principal
                
            
        } //ZStack
            
            
            
            
            
       
    }
}

#Preview {
    RecaudacionAreasView()
}
