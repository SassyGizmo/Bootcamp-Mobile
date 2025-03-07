//
//  CardsFightViewController.swift
//  PokerApp
//
//  Created by Bootcamp on 2025-03-06.
//

import UIKit

class CardsFightViewController: UIViewController {

    var cartas: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func convertirValor(_ valor: Int) -> String {
        switch valor {
        case 1:
            return "A"
        case 10:
            return "T"
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        default:
            return "\(valor)"
        }
    }
    
    func generateCards() {
        cartas.removeAll()
        for palo in ["S", "C", "H", "D"] {
            for i in 1...13 {
                let carta = "\(i)\(palo)"
                cartas.append(carta)
            }
        }
    }
    
    func extraerCartas() -> [String] {
        var cartasExtraidas: [String] = []
        for _ in 0...4 {
            let indexAleatorio = Int.random(in: 0..<cartas.count)
            let cartaExtraida = cartas.remove(at: indexAleatorio)
            cartasExtraidas.append(cartaExtraida)
        }

        return cartasExtraidas
    }
    
    func analizarMano(cartas: [String]) -> (tipo: String, valorMano: [Int]) {
        var valores = [Int]()
        var palos = [String]()
        
        for carta in cartas {
            let valor = Int(String(carta.prefix(carta.count - 1)))!
            let palo = String(carta.suffix(1))
            
            valores.append(valor)
            palos.append(palo)
        }
        
        // Ordenar los valores para analizar las secuencias
        valores.sort()
        
        // Comprobar si todas las cartas son del mismo palo
        let esColor = Set(palos).count == 1
        
        // Comprobar si los valores son secuenciales (Escalera)
        let esEscalera = valores.enumerated().allSatisfy { (index, valor) in
            index == 0 || valor == valores[index - 1] + 1
        }
        
        // Comprobar si es una escalera que involucra el As como un 1
        let esEscaleraConAs = valores == [1, 10, 11, 12, 13]
        
        // Verificar las combinaciones
        if esColor && esEscaleraConAs {
            return ("Escalera de Color", valores)
        }
        
        if esColor && esEscalera {
            return ("Escalera de Color", valores)
        }
        
        // Contar la frecuencia de cada valor
        var contadorValores = [Int: Int]()
        for valor in valores {
            contadorValores[valor, default: 0] += 1
        }
        
        if contadorValores.values.contains(4) {
            return ("Póker", valores)
        }
        
        if contadorValores.values.contains(3) && contadorValores.values.contains(2) {
            return ("Full", valores)
        }
        
        if esColor {
            return ("Color", valores)
        }
        
        if esEscalera || esEscaleraConAs{
            return ("Escalera", valores)
        }
        
        if contadorValores.values.contains(3) {
            return ("Trío", valores)
        }
        
        if contadorValores.values.filter({ $0 == 2 }).count == 2 {
            return ("Doble Pareja", valores)
        }
        
        if contadorValores.values.contains(2) {
            return ("Pareja", valores)
        }
        
        return ("Carta Alta", valores)
    }
    
    func compararManos(man1: [String], man2: [String]) -> String {
        // Analizar las manos
        let (tipoMano1, valoresMano1) = analizarMano(cartas: man1)
        let (tipoMano2, valoresMano2) = analizarMano(cartas: man2)
        
        // Lista de tipos de manos en orden de importacnia
        let tiposDeMano = ["Escalera de Color", "Póker", "Full", "Color", "Escalera", "Trío", "Doble Pareja", "Pareja", "Carta Alta"]
        
        // Comparar el tipo de mano
        if tiposDeMano.firstIndex(of: tipoMano1)! < tiposDeMano.firstIndex(of: tipoMano2)! {
            return "Mano 2 gana con \(tipoMano2)"
        } else if tiposDeMano.firstIndex(of: tipoMano1)! > tiposDeMano.firstIndex(of: tipoMano2)! {
            return "Mano 1 gana con \(tipoMano1)"
        } else {
            // Si ambas manos tienen el mismo tipo comparar la carta más alta
            for i in stride(from: valoresMano1.count - 1, through: 0, by: -1) {
                if valoresMano1[i] > valoresMano2[i] {
                    return "Mano 1 gana con \(convertirValor(valoresMano1[i]))"
                } else if valoresMano1[i] < valoresMano2[i] {
                    return "Mano 2 gana con \(convertirValor(valoresMano2[i]))"
                }
            }
            return "Empate"
        }
    }
    
    @IBAction func generateCards(_ sender: Any) {
        generateCards()
        let cardHand1: [String] = extraerCartas()
        let cardHand2: [String] = extraerCartas()
        
        let resultado1 = analizarMano(cartas: cardHand1)
        let resultado2 = analizarMano(cartas: cardHand2)
        
        print(resultado1)
        print(cardHand1)
        print("----------------------------------")
        print(resultado2)
        print(cardHand2)
        print(compararManos(man1: cardHand1, man2: cardHand2))
    }
}
