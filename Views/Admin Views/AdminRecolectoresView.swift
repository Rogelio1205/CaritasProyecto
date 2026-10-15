//
//  AdminRecolectoresView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 30/09/26.
//

import SwiftUI
import Charts

struct AdminRecolectoresView: View {
    
    @State private var datosRecMes = RecoleccionesMes(exitosas: 122, parciales: 32, reprogramadas: 26)
    @State private var listaRecHoy = [
                RecoleccionesHoy(cantidad: 8, estado: "Exitosas"),
                RecoleccionesHoy(cantidad: 2, estado: "Parciales"),
                RecoleccionesHoy(cantidad: 1, estado: "No recolectadas")
            ]
    let adminRecoleccionesService = AdminRecoleccionesService()
    
    var body: some View {
        
        @State var totalPromesas = datosRecMes.exitosas + datosRecMes.parciales + datosRecMes.reprogramadas

        
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
                    RecoleccionesInfoTexts(datosRecoleccionesMes: datosRecMes, totalPromesas: totalPromesas)
                    .task {
                        await cargarDatosRecMes()
                    }
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
                            Chart {
                                SectorMark(angle: .value("Valor", datosRecMes.exitosas), innerRadius: .ratio(0.7))
                                    .foregroundStyle( ColorConstants.lowRisk)
                                SectorMark(angle: .value("Valor", datosRecMes.parciales), innerRadius: .ratio(0.7))
                                    .foregroundStyle( ColorConstants.midRisk)
                                SectorMark(angle: .value("Valor", datosRecMes.reprogramadas), innerRadius: .ratio(0.7))
                                    .foregroundStyle( ColorConstants.highRisk)
                            }
                            .task {
                                await cargarDatosRecMes()
                            }
                            .chartLegend(position: .trailing, alignment: .leading, spacing: -00)
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
                                                Text("\(totalPromesas)")
                                                    .position(x: frame.midX, y: frame.midY)
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .foregroundStyle(ColorConstants.lowRisk)
                                            }
                                        }
                                    }
                                }
                                .padding(.trailing, 200)
                            VStack{
                                Text("\((Float(datosRecMes.exitosas) / Float(totalPromesas)) * 100, specifier: "%.0f")%")
                                    .bold()
                                    .foregroundStyle(ColorConstants.lowRisk)
                                    .font(.largeTitle)
                                Text("\((Float(datosRecMes.parciales) / Float(totalPromesas)) * 100, specifier: "%.0f")%")
                                    .bold()
                                    .foregroundStyle(Color(red: 0.53, green: 0.42, blue: 0.10))
                                    .font(.largeTitle)
                                Text("\((Float(datosRecMes.reprogramadas) / Float(totalPromesas)) * 100, specifier: "%.0f")%")
                                    .bold()
                                    .foregroundStyle(ColorConstants.highRisk)
                                    .font(.largeTitle)
                            }
                            .padding(.trailing, 100)
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
    
    func cargarDatosRecMes() async {
        do {
            datosRecMes = try await AdminRecoleccionesService.getDatosRecoleccionesMes()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
    func cargarDatosRecHoy() async {
        do {
            listaRecHoy = try await AdminRecoleccionesService.getDatosRecoleccionesHoy()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
}

#Preview {
    AdminRecolectoresView()
}
