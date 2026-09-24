//
//  PromesaTempView.swift
//  BOCETO_CARITAS
//
//  Created by Alumno on 23/09/26.
//

import SwiftUI

struct PromesaTempView: View {
    @State private var promesaActual: PromesaDetalle?
    @State private var listaEstados: [EstadoPromesa] = []
    
    var body: some View {
        VStack{
            if let promesa = promesaActual {
                Text("Monto: \(promesa.monto)")
            }
            
            Button("Cargar Datos"){
                Task{
                    do{
                        promesaActual = try await ObtenerPromesaDetalle(idPromesa: 1)
                        listaEstados = try await obtenerListaEstados()
                    } catch{
                        print("Error: \(error)")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    PromesaTempView()
}
