//
//  ViewController.swift
//  PokeAPIIntegration
//
//  Created by Bootcamp on 2025-03-07.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var inputTextLabel: UITextField!
    
    var userInput = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    func fetchPokemonData(pokemonName: String) {
            // URL de la PokeAPI
            let url = "https://pokeapi.co/api/v2/pokemon/\(pokemonName.lowercased())"
            
            AF.request(url).responseDecodable(of: Pokemon.self) { response in
                switch response.result {
                case .success(let pokemon):
                    // Imprimir información del Pokémon
                    print("Nombre: \(pokemon.name)")
                    print("ID: \(pokemon.id)")
                    print("Habilidades: \(pokemon.abilities.map { $0.ability.name })")
                    print("URL de sprite: \(pokemon.sprites.front_default)")

                    DispatchQueue.main.async {
                        self.nameLabel.text = "Nombre: \(pokemon.name)"
                        self.abilitiesLabel.text = "Habilidades: \(pokemon.abilities.map { $0.ability.name}.joined(separator: ", "))"
                                        
                        // Cargar la imagen del sprite del Pokémon
                         if let spriteUrl = URL(string: pokemon.sprites.front_default) {
                             self.pokemonImageView.kf.setImage(with: spriteUrl)
                        }
                    }

                case .failure(let error):
                    print("Error al obtener el Pokémon: \(error)")
                }
            }
        }
    
    @IBAction func TEST(_ sender: Any) {
        userInput = inputTextLabel.text ?? ""
        fetchPokemonData(pokemonName: userInput)
    }
    
}

