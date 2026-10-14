//
//  DonantesTopView.swift
//  BOCETO_CARITAS
//
//  Created by Medios Tecnológicos on 03/10/26.
//

import SwiftUI

struct DonantesTopView: View {
    //@State private var listaDonTop: [InfoDonantesTop]
    let topDonantesService = DonantesTopAdminService()
    @State private var listaDonantesTop: [InfoDonantesTop] = []
    @State private var montoPromedio = MontoPromedioGraphs(promedioTop: 0, promedioResto: 0)
    @State private var aportacion = AportacionTotalGraph(porcentajeTop: 0)
    @State private var widgets = WidgetsTopDiez(promedioTop: 0, promedioResto: 0, numDonantesTop: 0)
    @State private var sinConexionSeccionGraficas = false
    @State private var sinConexionRowTopDonantes = false
    
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
                    BubbleWidget(textColor: Color(red:66/255,green:66/255, blue: 66/255),title: "MEJORES 10%", titleFontSize: 14 , value: "\(widgets.numDonantesTop)", valueFontSize: 40, subtitle: "DONANTES", subtitleFontSize: 13)
                        .frame(width:250)
                    
                    var promRestoSinFormat = widgets.promedioResto
                    var promRestoFormatted = promRestoSinFormat.formatted(.number.precision(.fractionLength(0)))
                    BubbleWidget(textColor: Color(red:66/255,green:66/255, blue: 66/255), title: "PROMEDIO RESTO", titleFontSize: 14, value: "$\(promRestoFormatted)", valueFontSize: 40, subtitle: "PESOS POR DONANTE", subtitleFontSize: 13)
                        .frame(width:300)
                        .padding(.horizontal, 20)
                    
                    var promTopSinFormat = widgets.promedioTop
                    var promTopFormatted = promTopSinFormat.formatted(.number.precision(.fractionLength(0)))
                    BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "PROMEDIO TOP 10%", titleFontSize: 14, value: "$\(promTopFormatted)", valueFontSize: 40, subtitle: "PESOS POR DONANTE", subtitleFontSize: 13)
                        .frame(width:300)
                } // HSTAck bubble widgets
                .frame(height: 119)
                .padding( .horizontal)
                
                Text("TOP 10% VS RESTO DE DONANTES ")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .padding(.trailing,310)
                
                if (sinConexionSeccionGraficas == true){ //Sinconexion plantilla
                    SinConexionCard()
                        .padding(.top,35)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 50)
                } //Se muestra plantilla sin conexion
                
                else { // Plantilla normal
                    
                    VStack(alignment: .leading) { //Vstack carta
                        
                        Text("MONTO PROMEDIO DONADO POR DONANTE")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        
                        HStack { // HSTAck grafica top 10%
                            Text("Top 10%")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                            
                            var promTopSinFormat = widgets.promedioTop
                            var promTopFormatted = promTopSinFormat.formatted(.number.precision(.fractionLength(0)))
                            
                            ProgressView(value: montoPromedio.promedioTop, total: montoPromedio.promedioTop)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.leading, 115)
                            //.padding(.trailing, 50)
                                .tint(ColorConstants.mainColor)
                            
                            Text("$\(promTopFormatted)")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                                .minimumScaleFactor(0.8)
                                .frame(width: 140, alignment: .trailing)
                            
                        } //Hstack grafica top 10%
                        .padding(.top, 15)
                        
                        HStack { // HSTAck resto 90%
                            Text("Resto (90%)")
                                .font(.system(size: 25))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                            
                            ProgressView(value: montoPromedio.promedioResto, total: montoPromedio.promedioTop)
                                .scaleEffect(x: 1, y: 6)
                                .padding(.bottom, 20)
                                .padding(.leading, 70)
                                .tint(ColorConstants.mainColor)
                            
                            var promRestoSinFormat = widgets.promedioResto
                            var promRestoFormatted = promRestoSinFormat.formatted(.number.precision(.fractionLength(0)))
                            Text("$\(promRestoFormatted)")
                                .font(.system(size: 20))
                                .padding(.bottom, 20)
                                .fontWeight(.semibold)
                                .minimumScaleFactor(0.8)
                                .frame(width: 140, alignment: .trailing)
                        } //Hstack resto 90%
                        .padding(.top, 5)
                        
                        Text("APORTACIÓN AL TOTAL RECAUDADO")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                            .padding(.top, 15)
                        
                        ProgressView(value: aportacion.porcentajeTop, total: 100)
                            .scaleEffect(x: 1, y: 6)
                            .padding(.bottom, 20)
                            .tint(ColorConstants.mainColor)
                        
                        
                        HStack { //HStack puntos
                            HStack {
                                var porcentajeTopSinformat = aportacion.porcentajeTop
                                
                                var porcentajeTopFormatted = porcentajeTopSinformat.formatted(.number.precision(.fractionLength(0)))
                                
                                Circle()
                                    .fill(ColorConstants.mainColor.opacity(0.5))
                                    .frame(width: 10, height: 25)
                                
                                Text("Top 10% de donantes: \(porcentajeTopFormatted)%")
                                    .fontWeight(.semibold)
                            }
                            
                            HStack {
                                var porcentajeRestoSinformat = 100 - aportacion.porcentajeTop
                                
                                var porcentajeRestoFormatted = porcentajeRestoSinformat.formatted(.number.precision(.fractionLength(0)))
                                Circle()
                                    .fill(ColorConstants.mainColor.opacity(0.5))
                                    .frame(width: 10, height: 25)
                                
                                Text("Resto de donantes: \(porcentajeRestoFormatted)%")
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
                } // Plantilla normal
                
                VStack {
                    Text("DONANTES TOP 10%")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .padding(.trailing, 510)
                        .padding(.bottom,-10)
                    
                    if (sinConexionRowTopDonantes == true){ //Sinconexion plantilla
                        SinConexionCard()
                            .padding(.top,35)
                            .padding(.bottom, 20)
                    } //Se muestra plantilla sin conexion
                    
                    else { // Plantilla normal
                        List(listaDonantesTop) { topitem in
                            DonantesTopRow(topDonantes: topitem)
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.sidebar)
                    } // plantilla normal
                    
                }
                .padding(.horizontal, 50)
                .padding(.top, 20)
                
                
                
                Spacer()
                
            } // VStack Principal
            
            
        } // ZStack Fondo
        .task {
            do{
                listaDonantesTop = try await topDonantesService.getInfoRows()
                sinConexionRowTopDonantes = false
            }
            catch {
                sinConexionRowTopDonantes = true
                print("Error en TopDonanteRows: \(error) ")
            }
            
            do{
                montoPromedio = try await topDonantesService.getPromedioDonanteGraph()
                aportacion = try await topDonantesService.getAportacionTotal()
                sinConexionSeccionGraficas = false
            }
            catch {
                sinConexionSeccionGraficas = true
                print("Error graficas Monto promedio o Aportacion total: \(error)")
            }
            
            do {
                widgets = try await topDonantesService.getWidgetsTop()
            }
            catch {
                print ("Error en widgetsTop: \(error)")
            }
        }
    }
}

#Preview {
    DonantesTopView()
}
