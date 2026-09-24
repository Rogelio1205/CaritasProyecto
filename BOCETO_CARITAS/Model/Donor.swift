import Foundation

struct Donor : Codable {
    let nombre : String
    let apellidoPaterno : String
    let apellidoMaterno : String
    let nivelRiesgo : String
    let ultimaDonacion : String?
    let totalDonado : String?
    let telefonos: Telefonos
    let informacionGeneral : InformacionGeneral
    let promesas : [Promesa]
    let pagos : [Pago]
}

struct Telefonos: Codable {
    let casa: String?
    let movil: String?
    let temporal: String?
    let trabajo: String?
}

struct InformacionGeneral : Codable {
    let clasificacion : String
    let correo : String?
    let donanteEspecial : Bool
    let excluido : Bool
    let fechaExclusion : String?
    let tipoDonante : String
}

struct Promesa: Codable, Identifiable {
    let caso: String
    let frecuencia: String
    let id: Int
    let idEstado: Int
    let monto: Double
}

struct Pago: Codable {
    let estadoPago: String
    let fecha: String
    let id: Int
    let idPromesa: Int
    let importe: String
}

