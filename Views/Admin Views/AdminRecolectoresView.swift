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
        let listaPromesas = [
            RecoleccionesMes(estado: 1),
            RecoleccionesMes(estado: 2),
            RecoleccionesMes(estado: 3)
        ]
        VStack{
            Header()
            VStack {
                ScrollView {
                    HStack {
                        Spacer()
                        Text("RECOLECCIONES")
                            .font(.system(size: 65))
                            .bold()
                            .foregroundStyle(ColorConstants.mainColor)
                            .padding(.vertical, 25)
                            .padding(.trailing, 85)
                    }
                    RecoleccionesInfoTexts()
                    HStack {
                        Text("ESTADO DE RECOLECCIONES")
                            .padding()
                            .padding(.leading, 60)
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Chart(listaPromesas) { item in
                                SectorMark(angle: .value("Valor", item.estado), innerRadius: .ratio(0.7))
                                    .foregroundStyle(by: .value("Categoría", item.estado))
                            }.chartLegend(position: .bottom, alignment: .center)
                                .padding()
                            VStack{
                                Text("Exitosas")
                                    .bold()
                                Text("Parciales")
                                    .bold()
                                Text("No recolectadas")
                                    .bold()
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(20)
                    .background(Color(.white))
                    .cornerRadius(20)
                    .padding(.horizontal, 15)
                    HStack {
                        Text("RECOLECCIONES DE HOY")
                            .padding()
                            .padding(.leading, 60)
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                    }
                    Spacer()
                }
            }
        }.background(Color(.gray.opacity(0.05)))
    }
}

#Preview {
    AdminRecolectoresView()
}
