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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var falseClickButton: UIButton!
    @IBOutlet weak var missLabel: UILabel!
    
    // Variables para tiempo y puntos
    var timer : Timer?
    var timerLeft = 30
    var puntosPorClick = 0
    
    private let popupColor = UIColor(red: 216/255, green: 64/255, blue: 64/255, alpha: 1)
    
    // -----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missLabel.isHidden = true
        
        // Esconder el boton antes de empezar la partida
        clickButton.isHidden = true
        falseClickButton.isHidden = true
        
        // ocultar el popup al comienzo
        popupHidden()
        
        // Configuracion grafica de la caja de temporizador
        timerBox.layer.cornerRadius = 20
        timerBox.layer.masksToBounds = true
        
        // Configuraciones graficas de la alerta popup
        popup.layer.cornerRadius = 20
        popup.layer.masksToBounds = true
        popup.layer.borderWidth = 2
        popup.layer.borderColor = popupColor.cgColor
        
        // Mostrar el nombre del usuario ingresado en pantalla
        nameLabel.text = "\(String(describing: UserDefaults.standard.string(forKey: "LastUser")!))"
    }
    // -----------------------------------------------------
    
    // Funcion para ocultar popup
    func popupHidden() {
            popup.isHidden = true
            popupLabel.isHidden = true
            puntajePopup.isHidden = true
            popupButton.isHidden = true
    }
    
    // Funcion para mostrar popup
    func popupShow() {
            popup.isHidden = false
            popupLabel.isHidden = false
            puntajePopup.isHidden = false
            popupButton.isHidden = false
    }
    
    // Funcion para empezar el temporizador
    func startTimer() {
        timerLabel.text = "\(timerLeft)"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Actualizar valores del temporizador
    @objc func updateTimer() {
        // Restar segundos si aun quedan y actualizar el label de tiempo
        if timerLeft > 0 {
            timerLeft -= 1
            timerLabel.text = "\(timerLeft)"
        } else {
            // Actualizar el valor de puntos al finalizar el tiempo
            puntajePopup.text = "Puntaje: \(puntosPorClick)"
            popupShow()
            clickButton.isHidden = true
            falseClickButton.isHidden = true
            missLabel.isHidden = true
            timer?.invalidate()
            timerLabel.text = "Fin"
        }
    }
    
    // Funcion para parar el tiempo
    func stopTimer() {
        timer?.invalidate()
        timerLabel.text = "-"
    }
    
    // Funcion para mover el boton del juego al hacer click
    @objc func clickButtonTapped() {
        missLabel.isHidden = true
        // Declarar valores aleatorios para las coordenadas dentro del game field
        let newX = CGFloat.random(in: 50...(gameField.bounds.width - 50))
        let newY = CGFloat.random(in: 50...(gameField.bounds.height - 50))
        
        let falseNewX = CGFloat.random(in: 50...(gameField.bounds.width - 50))
        let falseNewY = CGFloat.random(in: 50...(gameField.bounds.height - 50))
        
        falseClickButton.frame = clickButton.frame
        var randomizer = 0
        
        // Animar el movimiento
        UIView.animate(withDuration: 0.5) {
        // Actualizar la posicion del boton respecto a las variables anteriores
            randomizer = Int.random(in: 0...3)
            if randomizer == 0 {
                self.falseClickButton.isHidden = false
                self.clickButton.center = CGPoint(x: newX, y: newY)
                self.falseClickButton.center = CGPoint(x: falseNewX, y: falseNewY)
                
            } else {
                self.falseClickButton.isHidden = true
                self.clickButton.center = CGPoint(x: newX, y: newY)
            }
            
            
        }
        puntosPorClick += 1
        pointsLabel.text = "\(puntosPorClick)"
    }

    
    @IBAction func falseClickButtonTapped(_ sender: Any) {
        missLabel.frame = falseClickButton.frame
        missLabel.isHidden = false
        puntosPorClick -= 1
        pointsLabel.text = "\(puntosPorClick)"
    }
    
    
    // Boton para empezar el juego
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
    
    // Boton para parar el juego
    @IBAction func stopButtonClick(_ sender: Any) {
        stopTimer()
        clickButton.isHidden = true
        falseClickButton.isHidden = true
        missLabel.isHidden = true
        popupShow()
        puntajePopup.text = "Puntaje: \(puntosPorClick)"
        
    }
    
    // Boton para cerrar el popup
    @IBAction func popupButtonTapped(_ sender: Any) {
        popupHidden()
        puntosPorClick = 0
        timerLeft = 0
        timerLabel.text = "\(puntosPorClick)"
    }
    
}
