//
//  StructureModel.swift
//  PokeAPIIntegration
//
//  Created by Bootcamp on 2025-03-07.
//

import Foundation

// Estructura para modelar la respuesta de la PokeAPI
struct Pokemon: Codable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let sprites: Sprites

    struct Ability: Codable {
        let ability: AbilityDetail
    }

    struct AbilityDetail: Codable {
        let name: String
    }

    struct Sprites: Codable {
        let front_default: String
    }
}

