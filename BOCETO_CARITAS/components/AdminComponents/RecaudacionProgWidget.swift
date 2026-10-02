//
//  RecaudacionProgWidget.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 01/10/26.
//

import SwiftUI

struct RecaudacionProgWidget: View {
    
    let progress: CGFloat
    
    var body: some View {
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
                            .padding(.bottom, 30)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("$186K")
                                    .font(.system(size: 75))
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("DE 259K PREVISTOS")
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
                                    .font(.system(size: 24, weight: .bold))
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
                    BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "LLAMADAS HOY", value: "128", valueFontSize: 40, subtitle: "LLAMADAS")
                        .frame(width:200)
                    BubbleWidget(backgroundColor: ColorConstants.lightLowRisk, textColor: ColorConstants.lowRisk, title: "PROMESAS HOY", value: "34", valueFontSize: 40, subtitle: "PROMESAS")
                        .frame(width:200)
                        .padding()
                }
                VStack {
                    BubbleWidget(backgroundColor: Color(red: 0/255, green: 113/255, blue: 130/255).opacity(0.1), textColor: Color(red: 0/255, green: 113/255, blue: 130/255), title: "RECOLECCIÓN", value: "68%", valueFontSize: 40, subtitle: "EXITOSA DEL MES")
                        .frame(width:200)
                    BubbleWidget(backgroundColor: Color(red: 0.92, green: 0.90, blue: 0.83), textColor: Color(red: 0.53, green: 0.42, blue: 0.10), title: "TOP 10%", value: "92", valueFontSize: 40, subtitle: "DONANTES")
                        .frame(width:200)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    let progressPrueba = 0.72
    RecaudacionProgWidget(progress: progressPrueba)
}
