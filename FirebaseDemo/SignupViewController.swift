//
//  SignupViewController.swift
//  FirebaseDemo
//
//  Created by Deepak Agrawal on 05/01/21.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        guard let email = self.emailTextField.text, !email.isEmpty else {
            print("Please enter correct email")
            return
        }
        
        guard let password = self.passwordTextField.text, password.count > 6 else {
            print("Error: The password must be 6 characters long or more.")
            return
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            
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
                self.navigationController?.popViewController(animated: true)
              }
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
