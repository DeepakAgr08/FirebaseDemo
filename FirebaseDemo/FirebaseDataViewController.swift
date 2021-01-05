//
//  FirebaseDataViewController.swift
//  FirebaseDemo
//
//  Created by Deepak Agrawal on 05/01/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirebaseDataViewController: UIViewController {

    @IBOutlet weak var dataTextField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        ref = Database.database().reference()
        self.dataTextField.isUserInteractionEnabled = false
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
          // Get user value
            let value = snapshot.value as? [String:Any]
            let text = value?["text"] as? String ?? ""
            self.dataTextField.text = text

          }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func editButtonClicked(_ sender: Any) {
        
        self.dataTextField.isUserInteractionEnabled = true
        self.dataTextField.becomeFirstResponder()
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        guard let text = self.dataTextField.text, !text.isEmpty else {
            print("Please enter text")
            return
        }
        self.dataTextField.isUserInteractionEnabled = false
        if let user = Auth.auth().currentUser{
            self.ref.child("users").child(user.uid).setValue(["text": text])
        }
    }
    
    @IBAction func exportButtonClicked(_ sender: Any) {
        guard let text = self.dataTextField.text, !text.isEmpty else {
            print("Please enter text")
            return
        }
        let items = [text]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
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
