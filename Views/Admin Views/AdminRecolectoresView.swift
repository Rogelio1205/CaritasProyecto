//
//  AdminRecolectoresView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import SwiftUI
import Charts

struct AdminRecolectoresView: View {
    var body: some View {
        let listaRecMes = [
            RecoleccionesMes(cantidad: 122, estado: "Exitosas"),
            RecoleccionesMes(cantidad: 32, estado: "Parciales"),
            RecoleccionesMes(cantidad: 26, estado: "No recolectadas")
        ]
        
        let listaRecHoy = [
            RecoleccionesHoy(cantidad: 7, estado: "Exitosas"),
            RecoleccionesHoy(cantidad: 2, estado: "Parciales"),
            RecoleccionesHoy(cantidad: 1, estado: "No recolectadas")
        ]
        
        VStack{
            Header()
            VStack {
                    HStack {
                        Spacer()
                        Text("RECOLECCIONES")
                            .font(.system(size: 65))
                            .bold()
                            .foregroundStyle(ColorConstants.mainColor)
                            .padding(.vertical, 15)
                            .padding(.trailing, 85)
                    }
                    RecoleccionesInfoTexts()
                    .padding(.horizontal, 30)
                    HStack {
                        Text("ESTADO DE RECOLECCIONES")
                            .padding()
                            .padding(.leading, 30)
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                    }
                VStack {
                        HStack {
                            Chart(listaRecMes) { item in
                                SectorMark(angle: .value("Valor", item.cantidad), innerRadius: .ratio(0.7))
                                    .foregroundStyle(by: .value("Categoría", item.estado))
                            }.chartLegend(position: .trailing, alignment: .center)
                                .chartForegroundStyleScale([
                                    "Exitosas": ColorConstants.lowRisk,
                                    "Parciales": ColorConstants.midRisk,
                                    "No recolectadas": ColorConstants.highRisk
                                ])
                                .chartBackground { chartProxy in
                                    GeometryReader { geometry in
                                        if let anchor = chartProxy.plotFrame {
                                            let frame = geometry[anchor]
                                            VStack {
                                                Text("180")
                                                    .position(x: frame.midX, y: frame.midY)
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .foregroundStyle(ColorConstants.lowRisk)
                                            }
                                        }
                                    }
                                }
                            VStack{
                                Text("68%")
                                    .bold()
                                    .foregroundStyle(ColorConstants.lowRisk)
                                    .font(.largeTitle)
                                Text("18%")
                                    .bold()
                                    .foregroundStyle(Color(red: 0.53, green: 0.42, blue: 0.10))
                                    .font(.largeTitle)
                                Text("14%")
                                    .bold()
                                    .foregroundStyle(ColorConstants.highRisk)
                                    .font(.largeTitle)
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(20)
                    .background(Color(.white))
                    .cornerRadius(20)
                    .padding(.horizontal, 30)
                    HStack {
                        Text("RECOLECCIONES DE HOY")
                            .padding()
                            .padding(.leading, 30)
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                    }
                VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("PROGRAMADAS HOY")
                                    .padding(.horizontal)
                                Text("12")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("COMPLETADAS")
                                    .padding(.horizontal)
                                Text("10")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("PENDIENTES")
                                    .padding(.horizontal)
                                Text("2")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                        }
                    Chart(listaRecHoy){ item in
                        BarMark(
                            x: .value("Estado", item.estado),
                            y: .value("Cantidad", item.cantidad)
                        )
                        .foregroundStyle(by: .value("Estado", item.estado))
                    }
                    .chartLegend(position: .bottom, alignment: .center)
                    .chartForegroundStyleScale([
                        "Exitosas": ColorConstants.lowRisk,
                        "Parciales": ColorConstants.midRisk,
                        "No recolectadas": ColorConstants.highRisk
                    ])

                }
                .padding()
                .cornerRadius(20)
                .background(Color(.white))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                    Spacer()
                }
        }.background(Color(.gray.opacity(0.05)))
    }
}

#Preview {
    AdminRecolectoresView()
}
