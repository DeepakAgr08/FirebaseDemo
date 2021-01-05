//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Deepak Agrawal on 05/01/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        guard let email = self.emailTextField.text, !email.isEmpty else {
            print("Please enter correct email")
            return
        }
        
        guard let password = self.passwordTextField.text, password.count > 6 else {
            print("Error: The password must be 6 characters long or more.")
            return
        }
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    print("Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                case .emailAlreadyInUse:
                    print("Error: The email address is already in use by another account.")
                case .invalidEmail:
                  print("Error: The email address is badly formatted.")
                case .weakPassword:
                    print("Error: The password must be 6 characters long or more.")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                print("User signs up successfully")
                self.performSegue(withIdentifier: "firebaseDataSegue", sender: self)
            }
        }
    }
}
