//
//  AuthScreenViewController.swift
//  likeVK
//
//  Created by Jambau on 02.11.2020.
//

import UIKit

class AuthScreenViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInWithAppleButton: UIButton!
    let MAIN_CORNER_RADIUS: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginAndPathTextFields()
        setupLogInButton()
        setupSignInWithAppleButton()
        changeLogInButtonStateByTextFields()
    }
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        loginTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    private func setupLoginAndPathTextFields() {
        let BORDER_WIDTH: CGFloat = 0.5
        let BORDER_COLOR = UIColor.systemGray4.cgColor
        let PLACEHOLDER_LEFT_OFFSET: CGFloat = 10
        
        loginTextField.layer.cornerRadius = MAIN_CORNER_RADIUS
        loginTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loginTextField.layer.borderWidth = BORDER_WIDTH
        loginTextField.layer.borderColor = BORDER_COLOR
        loginTextField.setLeftOffset(to: PLACEHOLDER_LEFT_OFFSET)
        
        passTextField.layer.cornerRadius = MAIN_CORNER_RADIUS
        passTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passTextField.layer.borderWidth = BORDER_WIDTH
        passTextField.layer.borderColor = BORDER_COLOR
        passTextField.setLeftOffset(to: PLACEHOLDER_LEFT_OFFSET)
    }
    
    private func setupLogInButton() {
        logInButton.layer.cornerRadius = MAIN_CORNER_RADIUS
        logInButton.isEnabled = false
    }
    
    private func setupSignInWithAppleButton() {
        signInWithAppleButton.layer.cornerRadius = MAIN_CORNER_RADIUS
    }
    
    private func changeLogInButtonStateByTextFields() {
        loginTextField.addTarget(self, action: #selector(changeLogInButtonStateByLoginTextField(_:)), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(changeLogInButtonStateByPassTextField(_:)), for: .editingChanged)
    }
    
    @objc private func changeLogInButtonStateByLoginTextField(_ loginTextField: UITextField) {
        if (loginTextField.text == nil || loginTextField.text == "")
            || (self.passTextField.text == nil || self.passTextField.text == "") {
            disableLogInButton()
        } else {
            enableLogInButton()
        }
    }
    
    @objc private func changeLogInButtonStateByPassTextField(_ passTextField: UITextField) {
        if (passTextField.text == nil || passTextField.text == "")
            || (self.loginTextField.text == nil || self.loginTextField.text == "") {
            disableLogInButton()
        } else {
            enableLogInButton()
        }
    }
    
    private func enableLogInButton() {
        logInButton.isEnabled = true
        logInButton.alpha = 1
    }
    
    private func disableLogInButton() {
        logInButton.isEnabled = false
        logInButton.alpha = 0.5
    }
}
