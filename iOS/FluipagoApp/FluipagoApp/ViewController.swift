//
//  ViewController.swift
//  FluipagoApp
//
//  Created by Bootcamp on 2025-02-24.
//

import UIKit


class ViewController: UIViewController {

    // Variables del formulario login
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    @IBOutlet weak var hiUserLabel: UILabel!
    @IBOutlet weak var userTypedCheck: UILabel!
    @IBOutlet weak var passwordTypedCheck: UILabel!
    
    // -----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        hiUserLabel.isHidden = true
    }
    // -----------------------------------------------------
    
    func autenticarUsuario(usuario: String, password: String) {
        
        // Varible checklist para verificar que ambos campos esten correctos
        var checklist = 0
        
        if userTextField.text! == UserDefaults.standard.string(forKey: "\(userTextField.text!)") {
            checklist += 1
        } else {
            userTypedCheck.text = "Usuario incorrecto"
        }
        
        if passwordTextField.text! == UserDefaults.standard.string(forKey: "\(userTextField.text! + passwordTextField.text!)") {
            checklist += 1
        } else {
            passwordTypedCheck.text = "Contrasena incorrecta"
        }
        
        
        if checklist == 2 {
            
            checklist = 0
            
            // Ir a la siguiente pantalla
            let gameScreen = self.storyboard?.instantiateViewController(withIdentifier: "gameID") as? GameViewController
            guard gameScreen != nil else { return }
            navigationController?.show(gameScreen!, sender: nil)
            
            // Configuracion para saludar al ultimo usuario ingresado
            UserDefaults.standard.set(userTextField.text, forKey: "LastUser")
            hiUserLabel.text = "¡Hola \(String(describing: UserDefaults.standard.string(forKey: "LastUser")!))!"
            hiUserLabel.isHidden = false
            
            // Reseteo de los cambos de usuario y contrasena incorrectos
            userTypedCheck.text = ""
            passwordTypedCheck.text = ""

        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let usuario = userTextField.text!
        let password = passwordTextField.text!
        autenticarUsuario(usuario: usuario, password: password)
    }
}

