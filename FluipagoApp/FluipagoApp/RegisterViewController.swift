//
//  RegisterViewController.swift
//  FluipagoApp
//
//  Created by Bootcamp on 2025-02-26.
//

import UIKit



class RegisterViewController: UIViewController {
    
    // Variables del formulario register
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var equalPasswordCheck: UILabel!
    @IBOutlet weak var equalPasswordCheck2: UILabel!
    
    
    // -----------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // -----------------------------------------------------
    
    // Funcion para la animacion de los campos de registro
    func shakeTextField(_ textField: UITextField) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.values = [0, -10, 10, -10, 10, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.5
        textField.layer.add(shakeAnimation, forKey: "shake")
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        // verificacion de campos vacios
        guard   let username = userTextField.text, !username.isEmpty,
                let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty,
                let repeatPassword = repeatPasswordField.text, !repeatPassword.isEmpty else {
                shakeTextField(userTextField)
                shakeTextField(emailTextField)
                shakeTextField(passwordTextField)
                shakeTextField(repeatPasswordField)
            return
        }
        
        // Verificacion de confirmacion de contrasena
        if password != repeatPassword {
            equalPasswordCheck.text = "Las contrasenas no coinciden"
            equalPasswordCheck2.text = "Las contrasenas no coinciden"
            return
        }
        
        // Guardado de datos del usuario en UserDefaults
        UserDefaults.standard.set(username, forKey: "\(username)")
        UserDefaults.standard.set(email, forKey: "\(username + email)")
        UserDefaults.standard.set(password, forKey: "\(username + password)")
        
        equalPasswordCheck.text = ""
        equalPasswordCheck2.text = ""
        print("Usuario registrado exitosamente.")
        
        

    }
    
}
