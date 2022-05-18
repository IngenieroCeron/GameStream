//
//  SearchGame.swift
//  GameStream
//
//  Created by Eduardo Ceron on 24/01/22.
//

import Foundation

class SearchGame: ObservableObject {
    
    @Published var gameInfo = [Game]()
    
    func search(gameName: String) {
        
        // esto tan solo es por precaucion para borrar lo que tenia
        gameInfo.removeAll()
        
        // Que es lo que hace esto? nosotros al momento de escribir la url de la peticion, esta peticion es un poco diferente, recibe parametros, y esos parametros pueden tener espacios por ejemlo si escrebimos cuphead no hay problema por que tan solo es un texto pero si buscamos the witcher tiene un espacio, aqui en la url normalmente no puede tener espacios, entonces vamos a utilizar ese gameNameSpaces para tener la habilidad de tener espacios dentro de la url de la peticion
        let gameNameSpaces = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // luego creamos esta variable que es la url de busqueda, es casi igual a la usada en el viremodel pero con la palabra serach?contains al ultimo, y despues le agregamos la variable que creamos anteriomente, despues con los dos signos de interrogacion le estamos diciendo que en caso de que no se pueda crear le damos un valor por defecto, en esta caso cuphead para que no tenga ningun error.
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games/search?contains=\(gameNameSpaces ?? "cuphead")")!
                
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do{
                
                if let jsonData = data {
                    print("tamaño del json \(jsonData)")
                    
                    let decodeData = try
                    JSONDecoder().decode(Resultados.self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.gameInfo.append(contentsOf: decodeData.results)
                    }
                    
                }
                
            }catch{
                print("Error: \(error)")
            }
        }.resume()
    }
}
