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
    @IBOutlet weak var pickerLabel: UITextField!
    
    var userInput = ""
    var data = ["Nombre", "ID"]
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerLabel.inputView = pickerView
        inputTextLabel.isEnabled = false
        

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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: Metodos
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if data[row] == "ID" {
            inputTextLabel.keyboardType = .numberPad
            inputTextLabel.isEnabled = true
            inputTextLabel.becomeFirstResponder()

        } else {
            inputTextLabel.keyboardType = .default
            inputTextLabel.isEnabled = true
            inputTextLabel.becomeFirstResponder()
        }
        pickerLabel.text = data[row]
    }
}
