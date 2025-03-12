//
//  PokemonManager.swift
//  PokedexApp
//
//  Created by Bootcamp on 2025-03-11.
//

import Foundation

protocol pokemonManagerDelegate {
    func showPokemonList(pokemonList: [Pokemon])
}

struct PokemonManager {
    var delegado: pokemonManagerDelegate?
    
    func verPokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener datos de la API: ",error?.localizedDescription as Any)
                }
                
                if let securedData = data?.parseData(removeString: "null,") {
                    if let pokemonList = self.parseJson(pokemonData: securedData) {
                        print(pokemonList)
                        
                        delegado?.showPokemonList(pokemonList: pokemonList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(pokemonData: Data) -> [Pokemon]? {
        let decodificator = JSONDecoder()
        do {
            let decodedData = try decodificator.decode([Pokemon].self, from: pokemonData)
            return decodedData
        } catch {
            print("Error al decodificar: ",error.localizedDescription)
            return nil
        }
    }
}

extension Data {
    func parseData(removeString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
