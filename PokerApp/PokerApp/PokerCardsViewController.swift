//
//  PokerCardsViewController.swift
//  PokerApp
//
//  Created by Bootcamp on 2025-03-05.
//

import UIKit

class PokerCardsViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var inHandView: UIView!
    @IBOutlet weak var inButtonContainer: UIView!
    @IBOutlet weak var buttonBack: UIView!
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card1Spot: UIView!
    @IBOutlet weak var card2Spot: UIView!
    @IBOutlet weak var card3Spot: UIView!
    @IBOutlet weak var card4Spot: UIView!
    @IBOutlet weak var card5Spot: UIView!
    @IBOutlet weak var labelHand: UILabel!
    @IBOutlet weak var gameField: UIView!
    
    var cardValue = 0
    var cardValueString = ""
    var cardSuitValue = 0
    var cardSuitString = ""
    var cardHand: Array<String> = ["", "", "", "", ""]

    
    var evaluateCardValue: Array<Int> = [0, 0, 0, 0, 0]
    var evaluateCardSuit: Array<String> = ["", "", "", "", ""]
    var dictionaryCounter: Dictionary<Int, Int> = [:]
    var checkThreeOfAKind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Visuals
        inHandView.layer.cornerRadius = 20
        inButtonContainer.layer.cornerRadius = 20
        buttonBack.layer.cornerRadius = 5
        card1.isHidden = true
        card2.isHidden = true
        card3.isHidden = true
        card4.isHidden = true
        card5.isHidden = true
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
        //evaluateCardValue = [9, 6, 9, 2, 6]
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
                return "STRAIGHT FLUSH"
            } else {
                return "STRAIGHT"
            }
        }
        
        // Evaluar escalera color ----------------------------------------------
        if evaluateCardValue[0] == evaluateCardValue[1] - 1 && evaluateCardValue[1] == evaluateCardValue[2] - 1 && evaluateCardValue[2] == evaluateCardValue[3] - 1 && evaluateCardValue[3] == evaluateCardValue[4] - 1 {
            if Set(evaluateCardSuit).count == 1 {
                return "STRAIGHT FLUSH"
            } else {
                return "STRAIGHT"
            }
        }
        
        // Evaluar Poker ----------------------------------------------
        dictionaryCounter.removeAll()
        for num in evaluateCardValue {
            dictionaryCounter[num, default: 0] += 1
        }
        
        if (dictionaryCounter.values.contains(4)) {
            dictionaryCounter.removeAll()
            return "FOUR OF A KIND"
        }
        
        // Evaluar Full ----------------------------------------------
        if Set(evaluateCardValue).count == 2 {
            return "FULL HOUSE"
        }
        
        // Evaluar color ----------------------------------------------
        if Set(evaluateCardSuit).count == 1 {
            return "FLUSH"
        }
        
        // Evaluar trio ----------------------------------------------
        for i in 0...3 {
            if evaluateCardValue[0] == evaluateCardValue[i+1] {
                checkThreeOfAKind += 1
            }
        }
        
        if checkThreeOfAKind == 2 {
            checkThreeOfAKind = 0
            return "THREE OF A KIND"
        }
        
        // Evaluar par doble ----------------------------------------------
        for i in 0...1 {
            if evaluateCardValue[i] == evaluateCardValue[i+1] && evaluateCardValue[i+2] == evaluateCardValue[i+3] {
                return "TWO PAIR"
            }
        }
        if evaluateCardValue[0] == evaluateCardValue[1] && evaluateCardValue[3] == evaluateCardValue[4] {
            return "TWO PAIR"
        }
        
        // Evaluar par ----------------------------------------------
        for i in 0...3 {
            if evaluateCardValue[0] == evaluateCardValue[i+1] {
                return "ONE PAIR"
            }
        }
        
        return "HIGH CARD"
    }
    
    func animateCards() {
        card1.isHidden = false
        card1.image = UIImage(named: "\(cardHand[0])")
        UIView.animate(withDuration: 0.1, animations: {
            self.card1.center = self.card1Spot.center
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.card2.isHidden = false
            self.card2.image = UIImage(named: "\(self.cardHand[1])")
            UIView.animate(withDuration: 0.1, animations: {
                self.card2.center = self.card2Spot.center
                
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.card3.isHidden = false
            self.card3.image = UIImage(named: "\(self.cardHand[2])")
            UIView.animate(withDuration: 0.1, animations: {
                self.card3.center = self.card3Spot.center
                
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.card4.isHidden = false
            self.card4.image = UIImage(named: "\(self.cardHand[3])")
            UIView.animate(withDuration: 0.1, animations: {
                self.card4.center = self.card4Spot.center
                
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.card5.isHidden = false
            self.card5.image = UIImage(named: "\(self.cardHand[4])")
            UIView.animate(withDuration: 0.1, animations: {
                self.card5.center = self.card5Spot.center
                
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.labelHandAnimation()
        }
    }
    
    func animationsReset() {
        card1.center = gameField.center
        card2.center = gameField.center
        card3.center = gameField.center
        card4.center = gameField.center
        card5.center = gameField.center
        card1.isHidden = true
        card2.isHidden = true
        card3.isHidden = true
        card4.isHidden = true
        card5.isHidden = true
        labelHand.text = ""
    }
    
    func labelHandAnimation() {
        labelHand.text = evaluateCardHand()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.labelHand.text = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.labelHand.text = self.evaluateCardHand()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.labelHand.text = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.labelHand.text = self.evaluateCardHand()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.labelHand.text = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.labelHand.text = self.evaluateCardHand()
        }
    }
    @IBAction func generateCards(_ sender: Any) {
        animationsReset()
        startButton.isEnabled = false
        print(generateCardHand())
        animateCards()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.startButton.isEnabled = true
        }
        
    }
    
}
