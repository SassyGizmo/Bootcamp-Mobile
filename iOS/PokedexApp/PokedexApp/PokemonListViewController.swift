//
//  ViewController.swift
//  PokedexApp
//
//  Created by Bootcamp on 2025-03-11.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    // MARK: -  IBOutlets
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    // MARK: - Variables
    var pokemonManager = PokemonManager()
    var pokemon: [Pokemon] = []
    var selectedPokemon: Pokemon?
    var filteredPokemon: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registrar la nueva celda
        pokemonTableView.register(UINib(nibName: "PokemonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
        
        pokemonManager.delegado = self
        pokemonSearchBar.delegate = self
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        // Ejecutar metodo para conseguir la lista de pokemon
        pokemonManager.verPokemon()
        
        
    }


}

// MARK: - SearchBar
extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemon = []
        
        if searchText == "" {
            filteredPokemon = pokemon
        } else {
            for poke in pokemon {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    filteredPokemon.append(poke)
                }
            }
        }
        
        self.pokemonTableView.reloadData()
    }
}

// MARK: - Delegado Pokemon
extension PokemonListViewController: pokemonManagerDelegate {
    func showPokemonList(pokemonList: [Pokemon]) {
        pokemon = pokemonList
        
        DispatchQueue.main.async {
            self.filteredPokemon = self.pokemon
            self.pokemonTableView.reloadData()
        }
    }
    
    
}

// MARK: - Tabla
extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! PokemonCellTableViewCell
        cell.pokemonNameTextLabel.text = filteredPokemon[indexPath.row].name
        cell.pokemonAttackTextLabel.text = "Ataque: \(filteredPokemon[indexPath.row].attack)"
        cell.pokemonDefenseTextLabel.text = "Defensa: \(filteredPokemon[indexPath.row].defense)"
        
        // Celda imagen desde URL
        let urlString = filteredPokemon[indexPath.row].imageUrl
        if let imageUrlDisplay = URL(string: urlString) {
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageUrlDisplay) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.pokemonImageView.image = image
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = filteredPokemon[indexPath.row]
        
        performSegue(withIdentifier: "showPokemon", sender: self)
        
        // Deseleccionar
        pokemonTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPokemon" {
            let showPokemon = segue.destination as! PokemonDetailsViewController
            showPokemon.showPokemon = selectedPokemon
        }
    }
}
