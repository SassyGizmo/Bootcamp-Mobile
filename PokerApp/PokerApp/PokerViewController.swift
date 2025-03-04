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
    
    @IBOutlet weak var mainDice: UIImageView!
    
    
    
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
        
        // Visuals del main dice
        
    }
    
    func mainDiceRoll() {
        mainDice.isHidden = false
        mainDice.image = UIImage(named: "dice-six-faces-one")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.mainDice.image = UIImage(named: "dice-six-faces-four")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.mainDice.image = UIImage(named: "dice-six-faces-six")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.mainDice.image = UIImage(named: "dice-six-faces-two")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.mainDice.image = UIImage(named: "dice-six-faces-three")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            self.mainDice.image = UIImage(named: "dice-six-faces-five")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { self.timer?.invalidate() }
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
        
        UIView.animate(withDuration: 0.1, animations: {
            if let center = targetCenter {
                self.diceOne.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.diceOne.isHidden = true
            self.mainDiceRoll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.1, animations: {
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
        
        UIView.animate(withDuration: 0.1, animations: {
            if let center = targetCenter {
                self.diceTwo.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.diceTwo.isHidden = true
            self.mainDiceRoll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.1, animations: {
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
        
        UIView.animate(withDuration: 0.1, animations: {
            if let center = targetCenter {
                self.diceThree.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.diceThree.isHidden = true
            self.mainDiceRoll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.1, animations: {
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
        
        UIView.animate(withDuration: 0.1, animations: {
            if let center = targetCenter {
                self.diceFour.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.diceFour.isHidden = true
            self.mainDiceRoll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.1, animations: {
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
        
        UIView.animate(withDuration: 0.1, animations: {
            if let center = targetCenter {
                self.diceFive.center = center
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.diceFive.isHidden = true
            self.mainDiceRoll()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.1, animations: {
                self.diceFive.isHidden = false
                self.mainDice.isHidden = true
                self.diceFive.center = originalPositionDiceFive
                self.topBorder.layer.backgroundColor = UIColor.beige.cgColor
                self.bottomBorder.layer.backgroundColor = UIColor.beige.cgColor
            })
        }
    }
    
    
    @IBAction func start(_ sender: Any) {
        startRainbowEffect()
        diceOneRoll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.startRainbowEffect()
            self.diceTwoRoll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.startRainbowEffect()
                self.diceThreeRoll()
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.startRainbowEffect()
                    self.diceFourRoll()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        self.startRainbowEffect()
                        self.diceFiveRoll()
                    }
                }
            }
        }
    }
}
