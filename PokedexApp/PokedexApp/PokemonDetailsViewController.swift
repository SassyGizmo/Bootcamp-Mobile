//
//  PokemonDetailsViewController.swift
//  PokedexApp
//
//  Created by Bootcamp on 2025-03-13.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    // MARK: - Variables
    var showPokemon: Pokemon?
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDescription: UITextView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Imagen a mostrar
        pokemonImage.loadFrom(urlAddress: showPokemon?.imageUrl ?? "")
        
        typeLabel.text = "Tipo: \(showPokemon?.type ?? "")"
        attackLabel.text = "Ataque: \(showPokemon?.attack ?? 0)"
        defenseLabel.text = "Defensa: \(showPokemon?.defense ?? 0)"
        pokemonDescription.text = showPokemon?.description ?? ""
    }
}

extension UIImageView {
    func loadFrom(urlAddress: String) {
        guard let url = URL(string: urlAddress) else { return }
        
//        DispatchQueue.main.async { [weak self] in
//            if let imageData = try? Data(contentsOf: url) {
//                if let loadedImage = UIImage(data: imageData) {
//                    self?.image = loadedImage
//                }
//            }
//        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            
            // Realizamos la solicitud con URLSession
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Verificar si ocurrió un error
                if let error = error {
                    print("Error al descargar la imagen: \(error.localizedDescription)")
                    return
                }
                
                // Verificar si los datos son válidos y si se puede crear una imagen
                guard let data = data, let loadedImage = UIImage(data: data) else {
                    print("No se pudo crear la imagen con los datos obtenidos.")
                    return
                }
                
                // Actualizamos la UI en el hilo principal
                DispatchQueue.main.async {
                    strongSelf.image = loadedImage
                }
            }.resume()
        }

    }
}
