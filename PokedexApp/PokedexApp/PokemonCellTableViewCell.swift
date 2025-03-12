//
//  PokemonCellTableViewCell.swift
//  PokedexApp
//
//  Created by Bootcamp on 2025-03-12.
//

import UIKit

class PokemonCellTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameTextLabel: UILabel!
    @IBOutlet weak var pokemonAttackTextLabel: UILabel!
    @IBOutlet weak var pokemonDefenseTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
