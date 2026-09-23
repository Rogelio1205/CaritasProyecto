//
//  RecolectoresMainView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 09/09/26.
//

import SwiftUI

struct RecolectoresMainView: View {
    
    @State private var Filtro = 1
    @State private var listaRecolecciones: Array<RecoleccionSiguiente> = [
        RecoleccionSiguiente(nombreDonante: "Melanie Rivera", diasHastaSigDonacion: 10, cantDonacion: 10236),
        RecoleccionSiguiente(nombreDonante: "Samuel Garza", diasHastaSigDonacion: 12, cantDonacion: 12466),
        RecoleccionSiguiente(nombreDonante: "Héctor Vargas", diasHastaSigDonacion: 15, cantDonacion: 8475)
    ]
    let recoleccionesService = RecoleccionesService()
    
    var body: some View {
        Header()
            VStack {
                Button("Cargar Lista de Supers") {
                    Task {
                        do {
                            listaRecolecciones = try await recoleccionesService.getListaRecoleccionesProx()
                        } catch {
                            print("Error en llamada: \(error)")
                        }
                    }
                }.buttonStyle(.borderedProminent)
                    .padding(.bottom, 10)
                HStack {
                    Spacer()
                    Text("SOLICITUDES")
                        .font(.system(size: 70))
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                        .padding()
                        .padding(.trailing, 65)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("RECOLECCIONES PENDIENTES")
                            .font(.system(size: 25))
                            .bold()
                            .padding(.top, 15)
                            .padding(.leading, 25)
                            .padding(.trailing, 25)
                        Text("34")
                            .font(.system(size: 50))
                            .bold()
                            .padding(.leading, 25)
                            .padding(.bottom, 15)
                    }
                    .background(Color(.gray.opacity(0.2)))
                    .cornerRadius(20)
                    .padding()
                    VStack(alignment: .leading) {
                        Text("RECOLECCIONES EN PROCESO")
                            .font(.system(size: 25))
                            .bold()
                            .padding(.top, 15)
                            .padding(.leading, 25)
                            .padding(.trailing, 25)
                        Text("5")
                            .font(.system(size: 50))
                            .bold()
                            .padding(.leading, 25)
                            .padding(.bottom, 15)
                    }
                    .background(Color(.gray.opacity(0.2)))
                    .cornerRadius(20)
                    .padding()
                }
                VStack {
                    VStack {
                        Text("RECOLECCIÓN PROYECTADA")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(ColorConstants.mainColor)
                        HStack {
                            Spacer()
                            Text("$31,761")
                                .font(.system(size: 60))
                                .bold()
                                .foregroundStyle(ColorConstants.mainColor)
                            Text("Pesos")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundStyle(ColorConstants.mainColor)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(.cyan.opacity(0.15)))
                    .cornerRadius(20)
                    VStack() {
                        GraficaRecoleccionesSemanales()
                            .padding()
                    }
                    .frame(height: 300)
                    .background(Color(.white))
                    .cornerRadius(20)
                    Picker(selection: $Filtro, label: Text("")){
                        Text("PRÓXIMAS").tag(1)
                        Text("MAYOR DONACIÓN").tag(2)
                    }.pickerStyle(.segmented)
                    List(listaRecolecciones) {recoleccionItem in
                        RecoleccionRow(recoleccionSig: recoleccionItem)
                    }
                    Spacer()
                }
                .padding(.leading, 80)
                .padding(.trailing, 80)
            }.background(Color(.gray.opacity(0.05)))
        
    }
}

#Preview {
    RecolectoresMainView()
}
