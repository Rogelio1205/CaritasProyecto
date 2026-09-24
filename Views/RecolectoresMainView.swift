//
//  RecolectoresMainView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 09/09/26.
//

import SwiftUI

struct RecolectoresMainView: View {
    
    @State private var Logout = false
    @State private var Filtro = 1
    @State private var listaRecolecciones: Array<RecoleccionSiguiente> = [
        RecoleccionSiguiente(apellidoPaterno: "Melanie", fecha: "30/09/2026", monto: 10236, nombre: "Rivera"),
        RecoleccionSiguiente(apellidoPaterno: "Garza", fecha: "12/09/2026", monto: 10236, nombre: "Samuel"),
        RecoleccionSiguiente(apellidoPaterno: "Vargas", fecha: "12/10/2026", monto: 10236, nombre: "Hector")
    ]
    let recoleccionesService = RecoleccionesService()
    
    var body: some View {
        headerMobile(logout: $Logout)
            VStack {
                HStack {
                    Spacer()
                    Text("SOLICITUDES")
                        .font(.system(size: 45))
                        .bold()
                        .foregroundStyle(ColorConstants.mainColor)
                        .padding()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("RECOLECCIONES PENDIENTES")
                            .bold()
                            .padding(.top, 15)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                        Text("34")
                            .bold()
                            .font(.largeTitle)
                            .padding(.bottom, 15)
                            .padding(.leading, 15)
                    }
                    .padding(.trailing, 4)
                    .background(Color(.gray.opacity(0.2)))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading) {
                        Text("RECOLECCIONES EN PROCESO")
                            .bold()
                            .padding(.top, 15)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                        Text("5")
                            .bold()
                            .font(.largeTitle)
                            .padding(.bottom, 15)
                            .padding(.leading, 15)
                    }
                    .padding(.leading, 4)
                    .background(Color(.gray.opacity(0.2)))
                    .cornerRadius(20)
                    
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
                    .background(Color(.white))
                    .cornerRadius(20)
                    .padding(.horizontal, 15)
                    Picker(selection: $Filtro, label: Text("")){
                        Text("PRÓXIMAS").tag(1)
                        Text("MAYOR DONACIÓN").tag(2)
                    }.pickerStyle(.segmented)
                    List(listaRecolecciones) { recoleccionItem in
                                RecoleccionRow(recoleccionSig: recoleccionItem)
                            }
                            .task {
                                await cargarLista()
                            }
                            .onChange(of: Filtro) { _ in
                                Task { await cargarLista() }
                            }
                    Spacer()
                }
                
            }.background(Color(.gray.opacity(0.05)))
        
    }
    private func cargarLista() async {
            if Filtro == 1 {
                do {
                    listaRecolecciones = try await RecoleccionesService.getListaRecoleccionesProx()
                } catch {
                    print("Error en llamada: \(error)")
                }
            } else {
                do {
                    listaRecolecciones = try await RecoleccionesService.getListaRecoleccionesProxByMonto()
                } catch {
                    print("Error en llamada: \(error)")
                }
            }
        }
}

#Preview {
    RecolectoresMainView()
}
