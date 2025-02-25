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
    
    private let primaryColor = UIColor(red: 164/255, green: 180/255, blue: 101/255, alpha: 1)
    private let secondaryColor = UIColor(red: 255/255, green: 207/255, blue: 80/255, alpha: 1)
    private let tertiaryColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.layer.borderColor = primaryColor.cgColor
        userTextField.layer.borderWidth = 1
        userTextField.layer.cornerRadius = 3
        
        passwordTextField.layer.borderColor = primaryColor.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 3
    
    }

}

