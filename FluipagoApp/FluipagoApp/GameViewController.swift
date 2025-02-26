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
    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var puntajePopup: UILabel!
    @IBOutlet weak var popupButton: UIButton!
    
    var timer : Timer?
    var timerLeft = 30
    var puntosPorClick = 0
    
    private let popupColor = UIColor(red: 216/255, green: 64/255, blue: 64/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        clickButton.isHidden = true
        popupHidden()
        
        
        timerBox.layer.cornerRadius = 20
        timerBox.layer.masksToBounds = true
        
        popup.layer.cornerRadius = 20
        popup.layer.masksToBounds = true
        popup.layer.borderWidth = 2
        popup.layer.borderColor = popupColor.cgColor
        
        
        //clickButton.center = CGPoint(x: gameField.bounds.midX, y: gameField.bounds.midY)
                
        
            
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func popupHidden() {
            popup.isHidden = true
            popupLabel.isHidden = true
            puntajePopup.isHidden = true
            popupButton.isHidden = true
    }
    
    func popupShow() {
            popup.isHidden = false
            popupLabel.isHidden = false
            puntajePopup.isHidden = false
            popupButton.isHidden = false
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
            puntajePopup.text = "Puntaje: \(puntosPorClick)"
            popupShow()
            clickButton.isHidden = true
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
        popupHidden()
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
        popupShow()
        puntajePopup.text = "Puntaje: \(puntosPorClick)"
        
    }
    @IBAction func popupButtonTapped(_ sender: Any) {
        popupHidden()
        puntosPorClick = 0
        timerLeft = 0
        timerLabel.text = "\(puntosPorClick)"
    }
    
}
