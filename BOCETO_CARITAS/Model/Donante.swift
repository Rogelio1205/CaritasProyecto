import Foundation

struct Donante: Identifiable {
    let id = UUID()
    let nombre: String
    let ultimaDonacion: String
    let riesgo: NivelRiesgo
}
