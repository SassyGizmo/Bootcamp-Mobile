//
//  PokerViewController.swift
//  PokerApp
//
//  Created by Bootcamp on 2025-03-04.
//

import UIKit

class PokerViewController: UIViewController {
    
    @IBOutlet weak var diceContainer: UIView!
    @IBOutlet weak var diceBoxLeft: UIView!
    @IBOutlet weak var diceBoxRight: UIView!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var topBorder: UIView!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var gameField: UIView!
    @IBOutlet weak var diceOne: UIImageView!
    @IBOutlet weak var diceTwo: UIImageView!
    @IBOutlet weak var diceThree: UIImageView!
    @IBOutlet weak var diceFour: UIImageView!
    @IBOutlet weak var diceFive: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var buttonBack: UIView!
    @IBOutlet weak var mainDice: UIImageView!
    
    let tinyTime: Double = 0.25
    let shortTime: Double = 0.1
    let longTime: Double = 2
    let largeTime: Double = 3
    
    var diceArray: Array<Int> = [0, 0, 0, 0, 0]
    var dictionaryCounter: Dictionary<Int, Int> = [1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0]
    
    
    
    var timer: Timer?
    var rainbowColorIndex = 0
    let rainbowColors: [UIColor] = [
        .rainbowRed, .rainbowOrange, .rainbowYellow,
        .rainbowGreen, .rainbowBlue, .rainbowIndigo, .rainbowViolet
    ]
    var diceRollsCounter = 0
    
    
    
    
    // -------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainDice.isHidden = true
        
        // Visuals
        diceContainer.layer.cornerRadius = 20
        diceBoxLeft.layer.cornerRadius = 20
        diceBoxRight.layer.cornerRadius = 20
        buttonContainer.layer.cornerRadius = 20
        topBorder.layer.cornerRadius = 5
        bottomBorder.layer.cornerRadius = 5
        buttonBack.layer.cornerRadius = 5
        
        // Visuals del main dice
        
    }
    
    func mainDiceRoll(index: Int) {
        mainDice.isHidden = false
        mainDice.image = UIImage(named: "dice-six-faces-1")
        DispatchQueue.main.asyncAfter(deadline: .now() + tinyTime) {
            self.mainDice.image = UIImage(named: "dice-six-faces-4")
            DispatchQueue.main.asyncAfter(deadline: .now() + self.tinyTime) {
                self.mainDice.image = UIImage(named: "dice-six-faces-6")
                DispatchQueue.main.asyncAfter(deadline: .now() + self.tinyTime) {
                    self.mainDice.image = UIImage(named: "dice-six-faces-2")
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.tinyTime) {
                        self.mainDice.image = UIImage(named: "dice-six-faces-3")
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.tinyTime) {
                            self.mainDice.image = UIImage(named: "dice-six-faces-5")
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.tinyTime) {
                                self.mainDice.image = UIImage(named: "dice-six-faces-\(index)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func startRainbowEffect() {
        // Detener cualquier timer activo antes de iniciar uno nuevo
        timer?.invalidate()
        rainbowColorIndex = 0
        
        // Iniciar el temporizador para cambiar el color cada 0.5 segundos durante 3 segundos
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateRainbow), userInfo: nil, repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + longTime) { self.timer?.invalidate() }
    }
    
    
    @objc func updateRainbow() {
        let color = rainbowColors[rainbowColorIndex]
        
        topBorder.layer.backgroundColor = color.cgColor
        bottomBorder.layer.backgroundColor = color.cgColor
        
        // Avanzar en el array de colores en bucle
        rainbowColorIndex = (rainbowColorIndex + 1) % rainbowColors.count
    }
    
    func diceOneRoll() {
        let originalPositionDiceOne = diceOne.center
        let targetCenter = gameField.superview?.convert(gameField.center, to: diceOne.superview)
        
        UIView.animate(withDuration: shortTime, animations: {
            if let center = targetCenter {
                self.diceOne.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + shortTime) {
            self.diceOne.isHidden = true
            self.diceArray[0] = Int.random(in: 1...6)
            self.mainDiceRoll(index: self.diceArray[0])
            self.diceOne.image = UIImage(named: "dice-six-faces-\(self.diceArray[0])")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + longTime) {
            UIView.animate(withDuration: self.shortTime, animations: {
                self.diceOne.isHidden = false
                self.mainDice.isHidden = true
                self.diceOne.center = originalPositionDiceOne
                self.topBorder.layer.backgroundColor = UIColor.beige.cgColor
                self.bottomBorder.layer.backgroundColor = UIColor.beige.cgColor
            })
        }
    }
    
    func diceTwoRoll() {
        let originalPositionDiceTwo = diceTwo.center
        let targetCenter = gameField.superview?.convert(gameField.center, to: diceTwo.superview)
        
        UIView.animate(withDuration: shortTime, animations: {
            if let center = targetCenter {
                self.diceTwo.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + shortTime) {
            self.diceTwo.isHidden = true
            self.diceArray[1] = Int.random(in: 1...6)
            self.mainDiceRoll(index: self.diceArray[1])
            self.diceTwo.image = UIImage(named: "dice-six-faces-\(self.diceArray[1])")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + longTime) {
            UIView.animate(withDuration: self.shortTime, animations: {
                self.diceTwo.isHidden = false
                self.mainDice.isHidden = true
                self.diceTwo.center = originalPositionDiceTwo
                self.topBorder.layer.backgroundColor = UIColor.beige.cgColor
                self.bottomBorder.layer.backgroundColor = UIColor.beige.cgColor
            })
        }
    }
    
    func diceThreeRoll() {
        let originalPositionDiceThree = diceThree.center
        let targetCenter = gameField.superview?.convert(gameField.center, to: diceThree.superview)
        
        UIView.animate(withDuration: shortTime, animations: {
            if let center = targetCenter {
                self.diceThree.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + shortTime) {
            self.diceThree.isHidden = true
            self.diceArray[2] = Int.random(in: 1...6)
            self.mainDiceRoll(index: self.diceArray[2])
            self.diceThree.image = UIImage(named: "dice-six-faces-\(self.diceArray[2])")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + longTime) {
            UIView.animate(withDuration: self.shortTime, animations: {
                self.diceThree.isHidden = false
                self.mainDice.isHidden = true
                self.diceThree.center = originalPositionDiceThree
                self.topBorder.layer.backgroundColor = UIColor.beige.cgColor
                self.bottomBorder.layer.backgroundColor = UIColor.beige.cgColor
            })
        }
    }
    
    func diceFourRoll() {
        let originalPositionDiceFour = diceFour.center
        let targetCenter = gameField.superview?.convert(gameField.center, to: diceFour.superview)
        
        UIView.animate(withDuration: shortTime, animations: {
            if let center = targetCenter {
                self.diceFour.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + shortTime) {
            self.diceFour.isHidden = true
            self.diceArray[3] = Int.random(in: 1...6)
            self.mainDiceRoll(index: self.diceArray[3])
            self.diceFour.image = UIImage(named: "dice-six-faces-\(self.diceArray[3])")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + longTime) {
            UIView.animate(withDuration: self.shortTime, animations: {
                self.diceFour.isHidden = false
                self.mainDice.isHidden = true
                self.diceFour.center = originalPositionDiceFour
                self.topBorder.layer.backgroundColor = UIColor.beige.cgColor
                self.bottomBorder.layer.backgroundColor = UIColor.beige.cgColor
            })
        }
    }
    
    func diceFiveRoll() {
        let originalPositionDiceFive = diceFive.center
        let targetCenter = gameField.superview?.convert(gameField.center, to: diceFive.superview)
        
        UIView.animate(withDuration: shortTime, animations: {
            if let center = targetCenter {
                self.diceFive.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + shortTime) {
            self.diceFive.isHidden = true
            self.diceArray[4] = Int.random(in: 1...6)
            self.mainDiceRoll(index: self.diceArray[4])
            self.diceFive.image = UIImage(named: "dice-six-faces-\(self.diceArray[4])")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + longTime) {
            UIView.animate(withDuration: self.shortTime, animations: {
                self.diceFive.isHidden = false
                self.mainDice.isHidden = true
                self.diceFive.center = originalPositionDiceFive
                self.topBorder.layer.backgroundColor = UIColor.beige.cgColor
                self.bottomBorder.layer.backgroundColor = UIColor.beige.cgColor
            })
        }
    }
    
    func evaluateHand() -> String {
        var checklist = 0
        if Set(diceArray).count == 1 {
            return "Generala"
        }
        for num in diceArray {
            dictionaryCounter[num, default: 0] += 1
        }
        
        if (dictionaryCounter.values.contains(4)) {
            return "Poker"
        }
        
        if (dictionaryCounter.values.contains(3) && dictionaryCounter.values.contains(2)) {
            return "Full"
        }
        
        if diceArray[0] == 1 {
            for i in 0...3 {
                if diceArray[i] == diceArray[i+1] - 1 {
                    checklist += 1
                }
            }
            
            if checklist == 4 {
                return "escalera"
            }
        }
        
        if diceArray[0] == 2 {
            for i in 0...3 {
                if diceArray[i] == diceArray[i+1] - 1 {
                    checklist += 1
                }
            }
            
            if checklist == 4 {
                return "escalera"
            }
        }
        
        if diceArray[0] == 3 {
            for i in 0...2 {
                if diceArray[i] == diceArray[i+1] - 1 {
                    checklist += 1
                }
            }
            
            if diceArray[3] == diceArray[4] + 5 {
                checklist += 1
            }
            
            if checklist == 4 {
                return "escalera"
            }
        }
        return "Nada"
    }
    
    
    @IBAction func start(_ sender: Any) {
        diceOne.image = UIImage(named: "dice-six-faces-empty")
        diceTwo.image = UIImage(named: "dice-six-faces-empty")
        diceThree.image = UIImage(named: "dice-six-faces-empty")
        diceFour.image = UIImage(named: "dice-six-faces-empty")
        diceFive.image = UIImage(named: "dice-six-faces-empty")
        
        startButton.isEnabled = false
        startRainbowEffect()
        diceOneRoll()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + largeTime) {
            self.startRainbowEffect()
            self.diceTwoRoll()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.largeTime) {
                self.startRainbowEffect()
                self.diceThreeRoll()
                DispatchQueue.main.asyncAfter(deadline: .now() + self.largeTime) {
                    self.startRainbowEffect()
                    self.diceFourRoll()
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.largeTime) {
                        self.startRainbowEffect()
                        self.diceFiveRoll()
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.largeTime) {
                            self.startButton.isEnabled = true
                            print(self.evaluateHand())
                            print(self.diceArray)
                        }
                    }
                }
            }
        }
    }
}
