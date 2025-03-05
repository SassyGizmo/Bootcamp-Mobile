//
//  PokerCardsViewController.swift
//  PokerApp
//
//  Created by Bootcamp on 2025-03-05.
//

import UIKit

class PokerCardsViewController: UIViewController {
    
    var cardValue = 0
    var cardValueString = ""
    var cardSuitValue = 0
    var cardSuitString = ""
    var cardHand: Array<String> = ["", "", "", "", ""]
    
    var evaluateCardValue: Array<Int> = [0, 0, 0, 0, 0]
    var evaluateCardSuit: Array<String> = ["", "", "", "", ""]
    var dictionaryCounter: Dictionary<Int, Int> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func generateCardValue(i: Int) -> String {
        cardValue = Int.random(in: 1...13)
        evaluateCardValue[i] = cardValue
        switch cardValue {
        case 1:
            cardValueString = "A"
        case 10:
            cardValueString = "T"
        case 11:
            cardValueString = "J"
        case 12:
            cardValueString = "Q"
        case 13:
            cardValueString = "K"
        default:
            cardValueString = String(cardValue)
        }
        //--------------------------
        //evaluateCardValue = [0, 9, 2, 1, 1]
        return cardValueString
    }
    
    func generateCardSuit(i: Int) -> String {
        cardSuitValue = Int.random(in: 1...4)
        switch cardSuitValue {
        case 1:
            cardSuitString = "S"
            evaluateCardSuit[i] = cardSuitString
        case 2:
            cardSuitString = "C"
            evaluateCardSuit[i] = cardSuitString
        case 3:
            cardSuitString = "H"
            evaluateCardSuit[i] = cardSuitString
        default:
            cardSuitString = "D"
            evaluateCardSuit[i] = cardSuitString
        }
        //--------------------------
        //evaluateCardSuit = ["S", "a", "S", "S", "S"]
        return cardSuitString
    }
    
    func generateCardHand() -> Array<String> {
        while true {
            for i in 0...4 {
                cardHand[i] = generateCardValue(i: i) + generateCardSuit(i: i)
            }
            if Set(cardHand).count == 5 {
                break
            }
        }
        return cardHand
    }
    
    func evaluateCardHand() -> String {
        // Evaluar escalera color inversa ----------------------------------------------
        if evaluateCardValue[4] == 1 && evaluateCardValue[3] == 13 && evaluateCardValue[2] == 12 && evaluateCardValue[1] == 11 && evaluateCardValue[0] == 10 {
            if Set(evaluateCardSuit).count == 1 {
                return "Escalera Color"
            } else {
                return "Escalera"
            }
        }
        
        // Evaluar escalera color ----------------------------------------------
        if evaluateCardValue[0] == evaluateCardValue[1] - 1 && evaluateCardValue[1] == evaluateCardValue[2] - 1 && evaluateCardValue[2] == evaluateCardValue[3] - 1 && evaluateCardValue[3] == evaluateCardValue[4] - 1 {
            if Set(evaluateCardSuit).count == 1 {
                return "Escalera Color"
            } else {
                return "Escalera"
            }
        }
        
        // Evaluar Poker ----------------------------------------------
        dictionaryCounter.removeAll()
        for num in evaluateCardValue {
            dictionaryCounter[num, default: 0] += 1
        }
        
        if (dictionaryCounter.values.contains(4)) {
            dictionaryCounter.removeAll()
            return "Poker"
        }
        
        // Evaluar Full ----------------------------------------------
        if Set(evaluateCardValue).count == 2 {
            return "Full"
        }
        
        // Evaluar color ----------------------------------------------
        if Set(evaluateCardSuit).count == 1 {
            return "Color"
        }
        
        // Evaluar trio ----------------------------------------------
        for i in 0...2 {
            if evaluateCardValue[i] == evaluateCardValue[i+1] && evaluateCardValue[i+1] == evaluateCardValue[i+2] {
                return "Trio"
            }
        }
        
        // Evaluar par doble ----------------------------------------------
        for i in 0...1 {
            if evaluateCardValue[i] == evaluateCardValue[i+1] && evaluateCardValue[i+2] == evaluateCardValue[i+3] {
                return "Par doble"
            }
        }
        if evaluateCardValue[0] == evaluateCardValue[1] && evaluateCardValue[3] == evaluateCardValue[4] {
            return "Par doble"
        }
        
        // Evaluar par ----------------------------------------------
        for i in 0...3 {
            if evaluateCardValue[i] == evaluateCardValue[i+1] {
                return "Par"
            }
        }
        
        return "Carta alta"
    }
    
    @IBAction func generateCards(_ sender: Any) {
        print(generateCardHand())
        print(evaluateCardHand())
    }
    
}
