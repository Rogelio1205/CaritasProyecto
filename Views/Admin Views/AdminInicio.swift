//
//  AdminInicio.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 29/09/26.
//

import SwiftUI
import Charts

struct AdminInicio: View {
    
    @State private var progresoRecaudacion = 0.72
    let listaCasosActivos = [
        CasosActivos(nombreCampaña: "Campaña Cáncer", descripcion: "Apoyo a tratamientos", recaudado: 48200, meta: 60000),
        CasosActivos(nombreCampaña: "Hambre Cero", descripcion: "Despensas para familias vulnerables", recaudado: 36750, meta: 50000),
        CasosActivos(nombreCampaña: "Campaña Karla Valdéz", descripcion: "Cirugía y rehabilitación", recaudado: 21300, meta: 40000)
    ]
    let listaRecaudacionesSemana = [
        RecaudacionPorSemana(semana: 1, recaudacion: 64700, recPrevista: 58200),
        RecaudacionPorSemana(semana: 2, recaudacion: 64700, recPrevista: 61900),
        RecaudacionPorSemana(semana: 3, recaudacion: 64700, recPrevista: 49300),
        RecaudacionPorSemana(semana: 4, recaudacion: 64800, recPrevista: 17000)
        ]
    
    var body: some View {
        
        VStack {
            Header()
            VStack {
                RecaudacionProgWidget(progress: progresoRecaudacion)
                HStack {
                    Text("RECAUDADO VS PREVISTO")
                        .padding()
                        .padding(.leading, 30)
                        .font(.system(size: 40))
                        .bold()
                    Spacer()
                }
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("RECAUDADO")
                                .padding(.horizontal)
                            Text("$186,420")
                                .foregroundStyle(ColorConstants.mainColor)
                                .padding(.horizontal)
                                .bold()
                                .font(.title)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("PREVISTO")
                                .padding(.horizontal)
                            Text("$258,900")
                                .padding(.horizontal)
                                .bold()
                                .font(.title)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("POR RECAUDAR")
                                .padding(.horizontal)
                            Text("$72,480")
                                .foregroundStyle(ColorConstants.highRisk)
                                .padding(.horizontal)
                                .bold()
                                .font(.title)
                        }
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
            }.padding()
        }.background(Color(.gray.opacity(0.05)))
    }
}

#Preview {
    AdminInicio()
}
