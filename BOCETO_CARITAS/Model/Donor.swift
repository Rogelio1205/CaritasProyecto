import Foundation

struct Donor : Codable {
    let nombre : String
    let apellidoPaterno : String
    let apellidoMaterno : String
    let telefonos: Telefonos
    
    let promesas : [Promesa]
}

struct Telefonos: Codable {
    let casa: String?
    let movil: String?
    let temporal: String?
    let trabajo: String?
}

struct Promesa: Codable {
    let caso: String
    let frecuencia: String
    let id: Int
    let idEstado: Int
    let monto: Double
}

