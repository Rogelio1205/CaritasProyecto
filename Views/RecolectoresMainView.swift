//
//  RecolectoresMainView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 09/09/26.
//

import SwiftUI

struct RecolectoresMainView: View {
    var body: some View {
        VStack {
            TopBar()
            .padding()
            Divider()
                .padding(.bottom, 10)
            HStack {
                Spacer()
                Text("SOLICITUDES")
                    .font(.system(size: 70))
                    .bold()
                    .foregroundStyle(Color(red: 0, green: 152/255, blue: 174/255))
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
                Text("RECOLECCIÓN PROYECTADA")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(Color(red: 0, green: 152/255, blue: 174/255))
                HStack {
                    Spacer()
                    Text("$31,761")
                        .font(.system(size: 60))
                        .bold()
                        .foregroundStyle(Color(red: 0, green: 152/255, blue: 174/255))
                    Text("Pesos")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundStyle(Color(red: 0, green: 152/255, blue: 174/255))
                    Spacer()
                }
            }
            .padding()
            .background(Color(.cyan.opacity(0.15)))
            .cornerRadius(20)
            .padding(.trailing, 80)
            .padding(.leading, 80)
            Spacer()
        }.background(Color(.gray.opacity(0.05)))
    }
}

#Preview {
    RecolectoresMainView()
}
