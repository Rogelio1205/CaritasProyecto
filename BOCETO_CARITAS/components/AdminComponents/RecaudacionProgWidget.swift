//
//  RecaudacionProgWidget.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import SwiftUI

struct RecaudacionProgWidget: View {
    
    let datosMontos: MontosDelMes
    let datosWidgetsAdmin: DatosGeneralesMain
    
    var body: some View {
        
        let progress: CGFloat = CGFloat(Float(datosMontos.montoRecaudado) / Float(datosMontos.montoPrevisto))
        
        VStack {
            HStack {
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text("RECAUDACIÓN")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundStyle(.white)
                        Text("SEPTIEMBRE 2026")
                            .font(.system(size: 30))
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.bottom)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("$\(datosMontos.montoRecaudado / 1000)K")
                                    .font(.system(size: 75))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("DE $\(datosMontos.montoPrevisto / 1000)K PREVISTOS")
                                    .font(.system(size: 30))
                                    .bold()
                                    .foregroundStyle(.white)
                            }
                            ZStack {
                                Circle()
                                    .stroke(Color(red: 0.14, green: 0.38, blue: 0.44), lineWidth: 14)
                                Circle()
                                    .trim(from: 0, to: min(progress, 1.0))
                                    .stroke(.white,
                                        style: StrokeStyle(lineWidth: 14, lineCap: .round, lineJoin: .round)
                                    )
                                    .foregroundColor(.blue)
                                    .rotationEffect(Angle(degrees: 270.0))
                                    .animation(.linear, value: progress)
                                Text("\(Int(progress * 100))%")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40, weight: .bold))
                            }
                            .frame(width: 150, height: 150)
                            .padding(.leading, 30)
                        
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                .padding()
                .cornerRadius(20)
                .background(ColorConstants.mainColor)
                .cornerRadius(20)
                .padding(.horizontal, 15)
                VStack {
                    BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "LLAMADAS HOY", value: "\(datosWidgetsAdmin.llamadasHoy)", valueFontSize: 40, subtitle: "LLAMADAS")
                        .frame(width:200)
                    BubbleWidget(backgroundColor: ColorConstants.lightLowRisk, textColor: ColorConstants.lowRisk, title: "PROMESAS HOY", value: "\(datosWidgetsAdmin.promesasHoy)", valueFontSize: 40, subtitle: "PROMESAS")
                        .frame(width:200)
                        .padding()
                }
                VStack {
                    BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "RECOLECCIÓN", value: "\(datosWidgetsAdmin.porcentajeRecolecciones)%", valueFontSize: 40, subtitle: "EXITOSA DEL MES")
                        .frame(width:200)
                    BubbleWidget(backgroundColor: Color(red: 0.92, green: 0.90, blue: 0.83), textColor: Color(red: 0.53, green: 0.42, blue: 0.10), title: "TOP 10%", value: "\(datosWidgetsAdmin.top10Donantes)", valueFontSize: 40, subtitle: "DONANTES")
                        .frame(width:200)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    let datosMontosPrueba = MontosDelMes(montoPrevisto: 258900, montoRecaudado: 186420, porRecaudar: 72480)
    let datosWidgetsMainPrueba = DatosGeneralesMain(llamadasHoy: 128, porcentajeRecolecciones: 68, promesasHoy: 34, top10Donantes: 92)
    RecaudacionProgWidget(datosMontos: datosMontosPrueba, datosWidgetsAdmin: datosWidgetsMainPrueba)
}
