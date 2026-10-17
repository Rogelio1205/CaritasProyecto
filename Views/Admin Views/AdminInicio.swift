//
//  AdminInicio.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI
import Charts

struct AdminInicio: View {
    
    let adminMainService = AdminMainService()
    
    @State private var listaCasosActivos = [
        CasosActivosMain(nombreCampaña: "Campaña Cáncer", descripcion: "Apoyo a tratamientos", recaudado: 48200, meta: 60000),
        CasosActivosMain(nombreCampaña: "Hambre Cero", descripcion: "Despensas para familias vulnerables", recaudado: 36750, meta: 50000),
        CasosActivosMain(nombreCampaña: "Campaña Karla Valdéz", descripcion: "Cirugía y rehabilitación", recaudado: 21300, meta: 40000)
    ]
    @State private var listaRecaudacionesSemana = [
        RecaudacionPorSemana(semana: 1, recaudacion: 64700, recPrevista: 58200),
        RecaudacionPorSemana(semana: 2, recaudacion: 64700, recPrevista: 61900),
        RecaudacionPorSemana(semana: 3, recaudacion: 64700, recPrevista: 49300),
        RecaudacionPorSemana(semana: 4, recaudacion: 64800, recPrevista: 17000)
        ]
    
    @State private var datosMontosAdminMain = MontosDelMes(montoPrevisto: 258900, montoRecaudado: 186420, porRecaudar: 72480)
    
    @State private var datosWidgetsAdminMain = DatosGeneralesMain(llamadasHoy: 128, porcentajeRecolecciones: 68, promesasHoy: 34, top10Donantes: 92)
    
    @State private var mesSeleccionado = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        
        VStack {
            Header()
            VStack {
                ScrollView {
                    RecaudacionProgWidget(datosMontos: datosMontosAdminMain, datosWidgetsAdmin: datosWidgetsAdminMain)
                        .task {
                            await cargarDatosRecMes()
                            await cargarDatosWidgetsMain()
                        }
                    HStack {
                        Text("RECAUDADO VS PREVISTO")
                            .padding()
                            .padding(.leading, 30)
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                        Menu {
                            Picker("Mes", selection: $mesSeleccionado) {
                                ForEach(1...12, id: \.self) { numero in
                                    Text(meses[numero - 1]).tag(numero)
                                }
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
                    }.padding(.trailing, 30)
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("RECAUDADO")
                                    .padding(.horizontal)
                                Text("$\(datosMontosAdminMain.montoRecaudado)")
                                    .foregroundStyle(ColorConstants.mainColor)
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("PREVISTO")
                                    .padding(.horizontal)
                                Text("$\(datosMontosAdminMain.montoPrevisto)")
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("POR RECAUDAR")
                                    .padding(.horizontal)
                                Text("$\(datosMontosAdminMain.porRecaudar)")
                                    .foregroundStyle(ColorConstants.highRisk)
                                    .padding(.horizontal)
                                    .bold()
                                    .font(.title)
                            }
                        }
                        .task {
                            await cargarDatosRecMes()
                        }
                        HStack {
                            Text("AVANCE SEMANAL")
                                .padding()
                                .font(.system(size: 25))
                                .bold()
                            Spacer()
                        }
                        Chart {
                            ForEach(listaRecaudacionesSemana) { item in
                                BarMark(
                                    x: .value("Day", item.semana),
                                    y: .value("Current", item.recaudacion),
                                    width: 50
                                )
                                .foregroundStyle(.cyan)
                                .position(by: .value("Data Type", "Current"), axis: .horizontal, span: 100)
                            }
                            ForEach(listaRecaudacionesSemana) { item in
                                BarMark(
                                    x: .value("Day", item.semana),
                                    y: .value("Average", item.recPrevista),
                                    width: 50
                                )
                                .foregroundStyle(ColorConstants.mainColor)
                                .position(by: .value("Data Type", "Average"), axis: .horizontal, span: 150)
                            }
                        }
                        .task {
                            await cargarDatosGraficasAdminMain()
                        }
                        .frame(height: 300)
                        .padding()
                        .chartXAxis {
                            AxisMarks(values: [0, 1, 2, 3, 4, 5]) { _ in
                                AxisTick()
                                AxisGridLine()
                                AxisValueLabel()
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(20)
                    .background(Color(.white))
                    .cornerRadius(20)
                    .padding(.horizontal, 30)
                    HStack {
                        Text("CASOS ACTIVOS")
                            .padding()
                            .padding(.leading, 30)
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                    }
                    ForEach(listaCasosActivos) { casoActivo in
                        CasosActivosRow(casoActivo:  casoActivo)
                    }
                    .task {
                        await cargarListaCasosActMain()
                    }
                }
            }.padding()
        }.background(Color(.gray.opacity(0.05)))
    }
    
    func cargarDatosRecMes() async {
        do {
            datosMontosAdminMain = try await AdminMainService.getMontosDelMes()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
    func cargarDatosWidgetsMain() async {
        do {
            datosWidgetsAdminMain = try await AdminMainService.getDatosWidgetsMain()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
    func cargarListaCasosActMain() async {
        do {
            listaCasosActivos = try await AdminMainService.getListaCasosActMain()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
    
    func cargarDatosGraficasAdminMain() async {
        do {
            listaRecaudacionesSemana = try await AdminMainService.getListaRecSemana()
        } catch {
            print("Error en llamada: \(error)")
        }
    }
}

#Preview {
    AdminInicio()
}
