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
    
    @State private var showAlert = false
    @State private var messageAlert = ""
    @State private var usuarioLogquado: LoginResponse? = nil
    @State private var estaLogueado: Bool = false
    
    private func verificacionLogin() {
        Task{
            do{
                if (username == "" || password == "") {
                    showAlert.toggle()
                    messageAlert = "Favor de rellenar todos los campos"
                    
                } else {
                    
                    let request = LoginRequest(userName: username, password_hash: password)
                    let response = try await verificarLogin(request)
                    
                    if(response.error != nil) {
                        showAlert.toggle()
                        messageAlert = "El correo o la contraseña son incorrectos"
                    } else {
                        usuarioLogquado = response
                        Sesion.shared.token = response.token
                        
                        if(response.idRol == 2) {
                            estaLogueado = true
                        } else {
                            showAlert.toggle()
                            messageAlert = "No cuentas con los permisos necesarios"
                        }
                    
                    }
                }
                    
            } catch {
                print("\(error)")
                showAlert.toggle()
                messageAlert = "Error en la conexión"
            }
        }
    }
    
    var body: some View {
        NavigationStack { // Navigation Stack
            VStack { // VStack principal
                HStack { // Barra de arriba
                    
                    Image("Caritas-Photoroom")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding(.leading, 20)
                    //.padding(.bottom, )
                    
                    Spacer()
                    
                } // Barra de arriba
                .background( // Se pone el fondo de esta manera para solo aplicar la sombra a la figura
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 10)
                        .padding(.bottom,20)
                )
                
                .overlay {
                    Rectangle()
                        .stroke(.gray, lineWidth: 1)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 10)
                
                // IMagen LOGO
                Image("Logo Cara y Cruz")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                
                Text("Cara y Cruz")
                    .font(.system(size: 52))
                    .fontWeight(.heavy)
                    .padding(.bottom, 44)
                
                
                VStack { // VStack reucadro blanco
                    
                    VStack (alignment: .leading) { // VStack campus de captura
                        Text("Iniciar Sesión")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        // .padding(.bottom, 35)
                            .padding(.leading, 36)
                        
                        Divider()
                            .padding(.bottom, 10)
                        
                        Text("Usuario")
                            .font(.system(size: 29))
                            .fontWeight(.bold)
                            .padding(.leading, 36)
                        
                        // Se hace el textField de manera manual para poder customizarlo
                        TextField("caritas@gmailcom", text: $username)
                            .textInputAutocapitalization(.never)
                            .font(.system(size: 26))
                            .padding(16) // Pading interior
                            .background(Color(red: 191/255, green: 190/255, blue: 186/255))
                            .cornerRadius(12) // Redondear borde
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red:0, green: 152/255, blue: 174/255), lineWidth: 3) // Color del borde
                            )
                            .padding(.horizontal, 36)
                            .padding(.bottom, 40)
                        
                        Text("Contraseña")
                            .font(.system(size: 29))
                            .fontWeight(.bold)
                            .padding(.leading, 36)
                        
                        SecureField("•••••••", text: $password)
                            .font(.system(size: 26))
                            .padding(16) // Padin interior
                            .background(Color(red: 191/255, green: 190/255, blue: 186/255))
                            .cornerRadius(12) // Redondear borde
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red:0, green: 152/255, blue: 174/255), lineWidth: 3) // Color del borde
                            )
                            .padding(.horizontal, 36)
                        
                    } // VStack campus de captura
                    
                    Button{
                        verificacionLogin()
                        print(username)
                    }
                    label: {
                        Text("INICIAR SESIÓN")
                            .frame(maxWidth: .infinity)
                            .padding(.top, 12)
                            .padding(.bottom, 12)
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .frame(maxWidth: 240)
                    .padding(.top, 44)
                    .tint(Color(red:0, green: 152/255, blue: 174/255))
                    .font(.system(size: 100))
                    .alert("\(messageAlert)", isPresented: $showAlert){
                        Button("OK"){}
                    }
                    
                    
                } // VStack reucadro blanco
                .padding(.vertical, 32)
                .background(.white.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .overlay {
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(.gray, lineWidth: 1)
                }
                .shadow(color: .gray, radius: 10)
                .padding(.horizontal, 48)
                
                
                
                Spacer()
                
            } // VStack principal
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background( // Degradado
                LinearGradient(
                    colors: [
                        Color(red: 195/255, green: 230/255, blue: 228/255),
                        Color(red:0, green: 152/255, blue: 174/255)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            ) // Degradado
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $estaLogueado)
            {
                ContentView(idUsuario: usuarioLogquado?.idUsuario ?? 0)
                //TabViewAdmin()
            }
        } // Navigation Stack
    }
}

#Preview {
    LoginView()
}
