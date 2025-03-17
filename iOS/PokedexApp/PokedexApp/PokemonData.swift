//
//  PokemonData.swift
//  PokedexApp
//
//  Created by Bootcamp on 2025-03-12.
//

import Foundation
import UIKit

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let name: String
    let imageUrl: String
    let type: String
    let description: String
}

struct PokemonImage {
    let pokemon: Pokemon
    let image: UIImage
}
