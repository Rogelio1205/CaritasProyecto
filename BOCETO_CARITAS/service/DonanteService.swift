import Foundation

class DonanteService {
    
    static let urlBase = "http://10.14.255.41:10206"
    
    static func getDonante(id : Int) async throws -> Donor{
        
        guard let url = URL(string:"\(urlBase)/donor?id=\(id)") else{
            print("URL incorrecto")
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Respuesta no válida del servidor")
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            print("Código de error del API: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let jsonDecoder = JSONDecoder()
        let donante = try jsonDecoder.decode(Donor.self, from: data)
        
        return donante
    }
}
