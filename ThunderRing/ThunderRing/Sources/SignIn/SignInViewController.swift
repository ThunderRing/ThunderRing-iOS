//
//  SignInViewController.swift
//  ThunderRing
//
//  Created by Hamin on 2022/04/16.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.addTarget(self, action: #selector(signInEvent), for: .touchUpInside)
    }
    
}

extension SignInViewController {
    @objc private func signInEvent(){
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil{
                print("login success")
                let view = TabBarController()
                view.modalPresentationStyle = .fullScreen
                view.modalTransitionStyle = .crossDissolve
                self.present(view, animated: true, completion:  nil)
            }
            else{
                
                print("login fail")
                
            }
            if (error != nil) {
                let alert = UIAlertController(title: "에러", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
