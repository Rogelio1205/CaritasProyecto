//
//  LoginView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 08/09/26.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack { // VStack principal
            HStack { // Barra de arriba
                HStack(spacing: 8) {
                    Image("Caritas-Photoroom")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 160)
                }
                Spacer()
                
            } // Barra de arriba
            .background(.white)
            
            //Spacer()
            
            // IMagen LOGO
            Image("Logo Cara y Cruz")
            
            Text("Cara y Cruz")
                .bold()
                .font(.system(size: 65))
                .padding(.bottom, 50)
            
            
            VStack { // VStack reucadro blanco
                
                VStack (alignment: .leading) { // VStack campus de captura
                    Text("Iniciar Sesión")
                        .font(.system(size: 60))
                        .bold()
                        .padding(.bottom, 35)
                        .padding(.leading, 45)
                    
                    Text("Usuario")
                        .font(.system(size: 45))
                        .bold()
                        .padding(.leading, 45)
                    
                    // Se hace el textField de manera manual para poder customizarlo
                    TextField("caritas@gmailcom", text: $username)
                        .font(.system(size: 45))
                        .padding(20) // Padin interior
                        .background(Color(red: 191/255, green: 190/255, blue: 186/255))
                        .cornerRadius(12) // Redondear borde
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(red:0, green: 152/255, blue: 174/255), lineWidth: 3) // Color del borde
                            )
                        .padding(.horizontal, 45)
                        .padding(.bottom, 50)
                    
                    Text("Contraseña")
                        .font(.system(size: 45))
                        .bold()
                        .padding(.leading, 45)
                    
                    TextField("*******", text: $password)
                        .font(.system(size: 45))
                        .padding(20) // Padin interior
                        .background(Color(red: 164/255, green: 164/255, blue: 164/255))
                        .cornerRadius(12) // Redondear borde
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(red:0, green: 152/255, blue: 174/255), lineWidth: 3) // Color del borde
                            )
                        .padding(.horizontal, 45)
                    
                } // VStack campus de captura
                
                Button{
                    // Pasa algo chido
                }
                label: {
                    Text("INICIAR SESIÓN")
                        .frame(maxWidth: .infinity)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        .font(.system(size: 35))
                        .bold()
                        
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                .frame(maxWidth: 300)
                .padding(.top, 55)
                .tint(Color(red:0, green: 152/255, blue: 174/255))
                .font(.system(size: 100))
                
            } // VStack reucadro blanco
            .padding(.vertical, 40)
            .background(.white.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .padding(.horizontal, 60)
            
        
        
        } // VStack principal
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red:0, green: 152/255, blue: 174/255))
        .ignoresSafeArea()
        
    }
}

#Preview {
    LoginView()
}
