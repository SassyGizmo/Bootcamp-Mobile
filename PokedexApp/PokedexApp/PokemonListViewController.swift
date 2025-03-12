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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registrar la nueva celda
        pokemonTableView.register(UINib(nibName: "PokemonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
        
        pokemonManager.delegado = self
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        // Ejecutar metodo para conseguir la lista de pokemon
        pokemonManager.verPokemon()
    }


}
// MARK: - Delegado Pokemon
extension PokemonListViewController: pokemonManagerDelegate {
    func showPokemonList(pokemonList: [Pokemon]) {
        pokemon = pokemonList
        
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
    
    
}

// MARK: - Tabla
extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! PokemonCellTableViewCell
        cell.pokemonNameTextLabel.text = pokemon[indexPath.row].name
        cell.pokemonAttackTextLabel.text = "Ataque: \(pokemon[indexPath.row].attack)"
        cell.pokemonDefenseTextLabel.text = "Defensa: \(pokemon[indexPath.row].defense)"
        
        // Celda imagen desde URL
        let urlString = pokemon[indexPath.row].imageUrl
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
}
