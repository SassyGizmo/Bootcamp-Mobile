//
//  ViewController.swift
//  FluipagoApp
//
//  Created by Bootcamp on 2025-02-24.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var userTypedCheck: UILabel!
    @IBOutlet weak var passwordTypedCheck: UILabel!
    
    private let primaryColor = UIColor(red: 164/255, green: 180/255, blue: 101/255, alpha: 1)
    private let secondaryColor = UIColor(red: 255/255, green: 207/255, blue: 80/255, alpha: 1)
    private let tertiaryColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func autenticarUsuario(usuario: String, password: String) {
        if usuario != "Junior" {
            userTypedCheck.text = "Usuario incorrecto"
        } else {
            userTypedCheck.text = ""
        }
        
        if password != "1234" {
            passwordTypedCheck.text = "Contrasena incorrecta"
        }
        
        if usuario == "Junior" && password == "1234" {

            let gameScreen = self.storyboard?.instantiateViewController(withIdentifier: "gameID") as? GameViewController
            guard gameScreen != nil else { return }
            navigationController?.show(gameScreen!, sender: nil)

        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let usuario = userTextField.text!
        let password = passwordTextField.text!
        
        autenticarUsuario(usuario: usuario, password: password)
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let registerScreen = self.storyboard?.instantiateViewController(withIdentifier: "registerID") as? RegisterViewController
        guard registerScreen != nil else { return }
        navigationController?.show(registerScreen!, sender: nil)
    }
    

}

