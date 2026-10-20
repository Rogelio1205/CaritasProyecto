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
    @State private var listaRecaudado: [RecaudadoArea] = []
    @State private var widgets = Widgets(areasActivas: 0, porRecaudar: 0.0, totalRecaudado: 0.0)
    @State private var sinConexionSeccionGraficas = false
    @State private var sinConexionRowCasosActivos = false
    
    var body: some View {
        ZStack { //ZStack
            
            Color(red:244/255, green:244/255, blue:244/255)
                .ignoresSafeArea()
            
            VStack{ // VSTack Header
                Header()
                
                ScrollView { // Scroll View
                    VStack{ // VStack principal
                        //Header()
                        Text("RECAUDACIÓN POR ÁREAS")
                            .padding(.top, 30)
                            .padding(.leading, 290)
                            .font(.system(size: 45))
                            .fontWeight(.heavy)
                            .foregroundStyle(Color(red:0, green: 152/255, blue: 174/255))
                        
                        HStack {
                            var porRecaudarSinFormat = widgets.porRecaudar
                            var totalSinFormat = widgets.totalRecaudado
                            
                            var porRecaudarFormat = porRecaudarSinFormat.formatted(.number.precision(.fractionLength(0)))
                            var totalFormat = totalSinFormat.formatted(.number.precision(.fractionLength(0)))
                            
                            BubbleWidget(textColor: Color(red:66/255,green:66/255, blue: 66/255),title: "AREAS ACTIVAS", titleFontSize: 14 , value: "\(widgets.areasActivas)", valueFontSize: 40, subtitle: "AREAS", subtitleFontSize: 13)
                                .frame(width:250)
                            
                            BubbleWidget(backgroundColor: Color(red: 124/255, green: 28/255, blue: 14/255).opacity(0.1), textColor: Color(red: 124/255, green: 28/255, blue: 14/255), title: "POR RECAUDAR", titleFontSize: 14, value: "$\(porRecaudarFormat)", valueFontSize: 40, subtitle: "PESOS", subtitleFontSize: 13)
                                .frame(width:300)
                                .padding(.horizontal, 20)
                                .lineLimit(1)
                            
                            BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "TOTAL RECAUDADO", titleFontSize: 14, value: "$\(totalFormat)", valueFontSize: 40, subtitle: "PESOS", subtitleFontSize: 13)
                                .frame(width:300)
                                .lineLimit(1)
                            
                        }
                        .frame(height: 119)
                        .padding( .horizontal)
                        
                        if (sinConexionSeccionGraficas == true){ //Sinconexion plantilla
                            SinConexionCard()                           
                                .padding(.bottom, 20)
                                .padding(.horizontal, 50)
                                .padding(.top,35)
                        } //Se muestra plantilla sin conexio
                        
                        else {
                            VStack(alignment: .leading) { // VSTACK Carta Graficas
                                Text("RECAUDADO VS META POR AREA")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20)
                                
                                ForEach(listaRecaudado) { recaudadoItem in
                                    Graficas(caso: recaudadoItem)
                                    
                                }
                                //.padding(.top,8)
                                
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
                        }
                        
                        
                        
                        VStack{
                            Text("CASOS ACTIVOS")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .padding(.trailing, 580)
                                .padding(.bottom,-10)
                            
                            if (sinConexionRowCasosActivos == true){ //Sinconexion plantilla
                                SinConexionCard()
                                    .padding(.top,35)
                                    .padding(.bottom, 20)
                            } //Se muestra plantilla sin conexion
                            
                            else { // Plantilla normal
                                
                                List(listaCasosAct) {casositem in
                                    CasosAcitvosRow(casosAct: casositem)
                                }
                                .scrollContentBackground(.hidden)
                                .listStyle(.sidebar)
                                .frame(height: 450)
                            } // Plantilla Normal
                            
                        }
                        .padding(.horizontal, 50)
                        .padding( .top, 20)
                                                
                    } // Vstack Principal
                } // Scroll View
            } // VSTACK header
            
        } //ZStack
        .task{
            do{
                listaCasosAct = try await recaudacionService.getCasosActivos()
                sinConexionRowCasosActivos = false
            }
            catch {
                sinConexionRowCasosActivos = true
                print("Error en row casos activos: \(error)")
            }
            
            do {
                    listaRecaudado = try await recaudacionService.getRecaudado()
                    sinConexionSeccionGraficas = false
                }
            
            catch {
                    sinConexionSeccionGraficas = true
                    print("Error gráficas: \(error)")
                }
            
            do {
                widgets = try await recaudacionService.getWidgets()
            }
            catch {
                print("Error en widgets: \(error)")
            }
        }
    }
}

#Preview {
    RecaudacionAreasView()
}
