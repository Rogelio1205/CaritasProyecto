//
//  RecaudacionAreasView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI
import Charts

struct RecaudacionAreasView: View {
    let recaudacionService = RecaudacionAreaService()
    @State private var listaCasosAct: [CasosActivos] = []
    /*@State private var listaCasos: Array<CasosActivos> = [
        CasosActivos(idCaso: 1, nombre: "Campaña Cancer", descripcion: "Apoyo a tratamientos oncologicos", totalPagado: 48200),
        CasosActivos(idCaso: 2, nombre: "Hambre Cero", descripcion: "Despensas para familias vulnerables", totalPagado: 36750),
        CasosActivos(idCaso: 3, nombre: "Educacion Integral", descripcion: "Becas y utiles escolares", totalPagado: 32470),
        CasosActivos(idCaso: 4, nombre: "Adultos Mayores", descripcion: "Medicaciones y atencion en asilos", totalPagado: 27900),
        CasosActivos(idCaso: 5, nombre: "Campaña Karla", descripcion: "Cirugia y rehabilitacion", totalPagado: 21300),
        CasosActivos(idCaso: 6, nombre: "Vivienda Digna", descripcion: "Mejoras de viviendas en colonias", totalPagado: 19800)
    ] */
    var body: some View {
        ZStack { //ZStack
            
            Color(red:244/255, green:244/255, blue:244/255)
                .ignoresSafeArea()
            
            //ScrollView {
                
                VStack{ // VStack principal
                    Header()
                    Text("RECAUDACIÓN POR ÁREAS")
                        .padding(.top, 30)
                        .padding(.leading, 290)
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color(red:0, green: 152/255, blue: 174/255))
                    
                    HStack {
                        
                        BubbleWidget(textColor: Color(red:66/255,green:66/255, blue: 66/255),title: "AREAS ACTIVAS", titleFontSize: 14 , value: "6", valueFontSize: 40, subtitle: "AREAS", subtitleFontSize: 13)
                            .frame(width:250)
                        
                        BubbleWidget(backgroundColor: Color(red: 124/255, green: 28/255, blue: 14/255).opacity(0.1), textColor: Color(red: 124/255, green: 28/255, blue: 14/255), title: "POR RECAUDAR", titleFontSize: 14, value: "$72, 480", valueFontSize: 40, subtitle: "PESOS", subtitleFontSize: 13)
                            .frame(width:300)
                            .padding(.horizontal, 20)
                        BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "TOTAL RECAUDADO", titleFontSize: 14, value: "$186, 420", valueFontSize: 40, subtitle: "PESOS", subtitleFontSize: 13)
                            .frame(width:300)
                        
                    }
                    .frame(height: 119)
                    .padding( .horizontal)
                    
                    VStack(alignment: .leading) { // VSTACK Carta Graficas
                        Text("RECAUDADO VS META POR AREA")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        
                        HStack { // HSTACK Grafica 1
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(ColorConstants.mainColor)
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                        } // HSTACK Grafica 1
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 2
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                                .fontWeight(.semibold)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(ColorConstants.mainColor)
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                        } // HSTACK Grafica 2
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 3
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(ColorConstants.mainColor)
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                        } // HSTACK Grafica 3
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 4
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(ColorConstants.mainColor)
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                        } // HSTACK Grafica 4
                        .padding( .top, 5)
                        
                        HStack { // HSTACK Grafica 5
                            
                            Text("Campña Cancer")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                            
                            ProgressView(value: 78, total: 100)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.horizontal, 30)
                                .tint(ColorConstants.mainColor)
                            
                            Text("$48,200 / $60,000")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                        } // HSTACK Grafica 5
                        .padding( .top, 5)
                        
                        HStack {
                            HStack {
                                Circle()
                                    .fill(ColorConstants.mainColor)
                                    .frame(width: 10, height: 25)
                                    
                                Text("Recaudado")
                                    .fontWeight(.semibold)
                            }
                            
                            
                            HStack {
                                Circle()
                                    .fill(ColorConstants.mainColor.opacity(0.5))
                                    .frame(width: 10, height: 25)
                                
                                Text("Falta por recaudar")
                                    .fontWeight(.semibold)
                            }
                            .padding(.leading, 35)
                        }
                        .padding(.bottom, 20)
                        
                    } // VSTACK Carta Graficas
                    .padding(.top, 20)
                    .padding( .horizontal, 30)
                    .background(. white)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .padding(.horizontal, 60)
                    .padding(.top, 35)
                    
                    
                    
                    VStack{
                        Text("CASOS ACTIVOS")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .padding(.trailing, 580)
                            .padding(.bottom,-10)
                        
                        
                        List(listaCasosAct) {casositem in
                            CasosAcitvosRow(casosAct: casositem)
                        }
                        .scrollContentBackground(.hidden) // Esconde la parte superior blanca de la pantalla
                        .listStyle(.sidebar)
                        
                    }
                    .padding(.horizontal, 50)
                    //. background(.purple)
                    .padding( .top, 20)
                    
                    Spacer()
                    
                } // Vstack Principal
            
        } //ZStack
        .task{
            do{
                listaCasosAct = try await recaudacionService.getCasosActivos()
            }
            catch {
                print("Error en la llamada: \(error)")
            }
        }
    }
}

#Preview {
    RecaudacionAreasView()
}
