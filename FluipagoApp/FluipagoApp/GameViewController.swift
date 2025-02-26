//
//  GameViewController.swift
//  FluipagoApp
//
//  Created by Bootcamp on 2025-02-26.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerBox: UIView!
    
    @IBOutlet weak var gameField: UIView!
    @IBOutlet weak var clickButton: UIButton!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        clickButton.center = CGPoint(x: gameField.bounds.midX, y: gameField.bounds.midY)
                
        clickButton.addTarget(self, action: #selector(moveButtonTapped), for: .touchUpInside)
            
        timerBox.layer.cornerRadius = 20
        timerBox.layer.masksToBounds = true
    }
    
    @objc func moveButtonTapped() {
            // Definir una nueva posición dentro del contenedor
        let newX = CGFloat.random(in: 50...(gameField.bounds.width - 50))
        let newY = CGFloat.random(in: 50...(gameField.bounds.height - 50))
            
            // Animar el movimiento
            UIView.animate(withDuration: 0.5) {
                self.clickButton.center = CGPoint(x: newX, y: newY)
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
