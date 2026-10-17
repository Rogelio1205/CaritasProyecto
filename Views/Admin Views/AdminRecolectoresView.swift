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
    @State private var recoleccionesDeHoy = RecoleccionesHoy(Completadas: 10, Pendientes: 2, parciales: 3, programadasHoy: 15)
    let adminRecoleccionesService = AdminRecoleccionesService()
    @State private var mesSeleccionado = Calendar.current.component(.month, from: Date())
    
    private var formatoHoy: DateFormatter {
            let f = DateFormatter()
            f.dateFormat = "dd MMM"
            f.locale = Locale(identifier: "es_MX")
            return f
        }
    
    var body: some View {
        
        @State var totalPromesas = datosRecMes.exitosas + datosRecMes.parciales + datosRecMes.reprogramadas

        
        VStack{

            Header()
            VStack {
                    HStack {
                        Menu {
                            Picker("Mes", selection: $mesSeleccionado) {
                                Text("Enero").tag(1)
                                Text("Febrero").tag(2)
                                Text("Marzo").tag(3)
                                Text("Abril").tag(4)
                                Text("Mayo").tag(5)
                                Text("Junio").tag(6)
                                Text("Julio").tag(7)
                                Text("Agosto").tag(8)
                                Text("Septiembre").tag(9)
                                Text("Octubre").tag(10)
                                Text("Noviembre").tag(11)
                                Text("Diciembre").tag(12)
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Text(meses[mesSeleccionado - 1])
                                    .font(.system(size: 38, weight: .semibold))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            .foregroundStyle(ColorConstants.mainColor)
                        }
                        .padding(.leading, 50)
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
                    .padding(.top)
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
                            .task(id: mesSeleccionado) {
                                await cargarDatosRecMes()
                            }
                            .chartLegend(.hidden)
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
                                                Text("          \(totalPromesas) \n PROMESAS")
                                                    .position(x: frame.midX, y: frame.midY)
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .foregroundStyle(ColorConstants.lowRisk)
                                            }
                                        }
                                    }
                                }
                                .padding(.trailing, 00)
                            VStack(alignment: .leading){
                                Text("\((Float(datosRecMes.exitosas) / Float(totalPromesas)) * 100, specifier: "%.0f")% EXITOSAS")
                                    .bold()
                                    .foregroundStyle(ColorConstants.lowRisk)
                                    .font(.largeTitle)
                                Text("\((Float(datosRecMes.parciales) / Float(totalPromesas)) * 100, specifier: "%.0f")% PARCIALES")
                                    .bold()
                                    .foregroundStyle(Color(red: 0.53, green: 0.42, blue: 0.10))
                                    .font(.largeTitle)
                                Text("\((Float(datosRecMes.reprogramadas) / Float(totalPromesas)) * 100, specifier: "%.0f")% NO RECOLECTADAS")
                                    .bold()
                                    .foregroundStyle(ColorConstants.highRisk)
                                    .font(.largeTitle)
                            }
                            .padding(.trailing, 30)
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
                        Text(formatoHoy.string(from: Date()).localizedUppercase)
                            .bold()
                            .foregroundStyle(ColorConstants.mainColor)
                            .font(.system(size: 40))
                            .padding(.trailing, 50)
                    }
                VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("PROGRAMADAS HOY")
                                    .padding(.horizontal)
                                Text("\(recoleccionesDeHoy.programadasHoy)")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("COMPLETADAS")
                                    .padding(.horizontal)
                                Text("\(recoleccionesDeHoy.Completadas)")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("PENDIENTES")
                                    .padding(.horizontal)
                                Text("\(recoleccionesDeHoy.Pendientes)")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                        }
                        .task {
                            await cargarDatosRecHoy()
                        }
                    Chart{
                        BarMark(
                            x: .value("Estado", "EXITOSAS"),
                            y: .value("Cantidad", recoleccionesDeHoy.Completadas)
                        )
                        .foregroundStyle(ColorConstants.lowRisk)
                        BarMark(
                            x: .value("Estado", "PARCIALES"),
                            y: .value("Cantidad", recoleccionesDeHoy.parciales)
                        )
                        .foregroundStyle(ColorConstants.midRisk)
                        BarMark(
                            x: .value("Estado", "NO RECOLECTADAS"),
                            y: .value("Cantidad", recoleccionesDeHoy.Pendientes)
                        )
                        .foregroundStyle(ColorConstants.highRisk)
                    }
                    .task {
                        await cargarDatosRecHoy()
                    }
                    .chartLegend(.hidden)
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
            datosRecMes = try await AdminRecoleccionesService.getDatosRecoleccionesMes(mes: mesSeleccionado)
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
    func cargarDatosRecHoy() async {
        do {
            recoleccionesDeHoy = try await AdminRecoleccionesService.getDatosRecoleccionesHoy()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
}

#Preview {
    AdminRecolectoresView()
}
