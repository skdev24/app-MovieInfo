//
//  SignupVC.swift
//  MovieInfo
//
//  Created by Shivam Dev on 14/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var signupScrollView: UIScrollView!
    
    var currentView = changeView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UITEXTFIELD
        let email = emailTextField.border(textField: emailTextField)
        emailTextField.layer.addSublayer(email)
        emailTextField.layer.masksToBounds = true
        
        let username = userNameTextField.border(textField: userNameTextField)
        userNameTextField.layer.addSublayer(username)
        userNameTextField.layer.masksToBounds = true
        
        let password = passWordTextField.border(textField: passWordTextField)
        passWordTextField.layer.addSublayer(password)
        passWordTextField.layer.masksToBounds = true
        
        //delegate
        emailTextField.delegate = self
        passWordTextField.delegate = self
        userNameTextField.delegate = self
        
        currentView.currentScrollView = signupScrollView
        currentView.view = view
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentView.subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentView.unsubscribeFromKeyboardNotification()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        //        loginScrollView.contentInset = contentInset
        currentView.keyboardWillHide()
        return false
    }

    @IBAction func dissMissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func creatAccountWasPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passWordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                //success
                print("USER REGESTRATION SUCCESSFUL!")
            }        }
        
    }
    
    
}


extension UITextField {
    
    func border(textField: UITextField) -> CALayer {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth = width
        return border
    }
    
}
