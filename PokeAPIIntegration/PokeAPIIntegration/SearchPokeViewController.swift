// PokemonSearchPicker.swift

import UIKit

struct Pokemon: Decodable {
    let name: String
    let types: [String]
}

class PokeAPI {
    static func fetchAllPokemon(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1000")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])));
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonResponse.self, from: data)
                let pokemonList = result.results.map { Pokemon(name: $0.name, types: []) }
                completion(.success(pokemonList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct PokemonResponse: Decodable {
    let results: [PokemonResult]
}

struct PokemonResult: Decodable {
    let name: String
    let url: String
}

class PokemonSearchPickerViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var allPokemon: [Pokemon] = []
    var filteredPokemon: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self

        fetchAllPokemon()
    }

    func fetchAllPokemon() {
        PokeAPI.fetchAllPokemon { [weak self] result in
            switch result {
            case .success(let pokemonList):
                self?.allPokemon = pokemonList
                self?.filteredPokemon = pokemonList
                DispatchQueue.main.async {
                    self?.pickerView.reloadAllComponents()
                }
            case .failure(let error):
                print("Error fetching Pokémon: \(error)")
            }
        }
    }

    func filterPokemon(with query: String) {
        if query.isEmpty {
            filteredPokemon = allPokemon
        } else {
            filteredPokemon = allPokemon.filter { pokemon in
                pokemon.name.lowercased().contains(query.lowercased())
            }
        }
        pickerView.reloadAllComponents()
    }
}

extension PokemonSearchPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPokemon(with: searchText)
    }
}

extension PokemonSearchPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filteredPokemon.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filteredPokemon[row].name.capitalized
    }
}
