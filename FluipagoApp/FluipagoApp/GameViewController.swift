//
//  GameViewController.swift
//  FluipagoApp
//
//  Created by Bootcamp on 2025-02-26.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerBox: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var gameField: UIView!
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var timer : Timer?
    var timerLeft = 30
    var puntosPorClick = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clickButton.isHidden = true
        timerBox.layer.cornerRadius = 20
        timerBox.layer.masksToBounds = true
        
        //clickButton.center = CGPoint(x: gameField.bounds.midX, y: gameField.bounds.midY)
                
        
            
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func startTimer() {
        timerLabel.text = "\(timerLeft)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if timerLeft > 0 {
            timerLeft -= 1
            timerLabel.text = "\(timerLeft)"
        } else {
            timer?.invalidate()
            timerLabel.text = "Fin"
            
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timerLabel.text = "-"
    }
    
    @objc func clickButtonTapped() {
        let newX = CGFloat.random(in: 50...(gameField.bounds.width - 50))
        let newY = CGFloat.random(in: 50...(gameField.bounds.height - 50))
        
        // Animar el movimiento
        //            UIView.animate(withDuration: 0.5) {
        self.clickButton.center = CGPoint(x: newX, y: newY)
        puntosPorClick += 1
        pointsLabel.text = "\(puntosPorClick)"
        //            }
    }
    
    @IBAction func startButtonClick(_ sender: Any) {
        clickButtonTapped()
        puntosPorClick = 0
        pointsLabel.text = "0"
        timerLeft = 30
        clickButton.isHidden = false
        stopTimer()
        startTimer()
        clickButton.addTarget(self, action: #selector(clickButtonTapped), for: .touchUpInside)
    }
    @IBAction func stopButtonClick(_ sender: Any) {
        stopTimer()
        clickButton.isHidden = true
        
    }
    
}
