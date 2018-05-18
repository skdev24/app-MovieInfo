//
//  ViewController.swift
//  MovieInfo
//
//  Created by Shivam Dev on 14/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextFiel: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginScrollView: UIScrollView!
    
    var currentView = changeView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TextViewLayout
        userNameTextFiel.layer.borderColor = UIColor.white.cgColor;
        userNameTextFiel.layer.borderWidth = 3.0;
        userNameTextFiel.layer.cornerRadius = 30.0;
        passWordTextField.layer.borderColor = UIColor.white.cgColor;
        passWordTextField.layer.borderWidth = 3.0;
        passWordTextField.layer.cornerRadius = 30.0;
        
        userNameTextFiel.delegate = self
        passWordTextField.delegate = self
        
        currentView.currentScrollView = loginScrollView
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

    
    @IBAction func userNameTextFieldWasPressed(_ sender: UITextField) {
        sender.text = ""
    }
    @IBAction func passwordTextFieldWasPressed(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func loginBtnWasPressed(_ sender: UIButton) {
        
//        performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    @IBAction func dissMissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}


















