//
//  Loginpage.swift
//  Varisty
//
//  Created by Christian Grinling on 21/11/2020.
//

import UIKit
import Firebase

class Loginpage: UIViewController {
    
    var logoColour = UIColor.white//UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
    var logoImageColour = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
    let borderwidth = CGFloat(3)
    let cornervalue = CGFloat(20)
    let grayColour = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    
    lazy var LogoImage: UIImageView = {
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.image = UIImage(named: "colourlogo")
         return image
     }()
    
    lazy var LoginTitle: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.layer.masksToBounds = true
        textfield.addPadding()
        return textfield
    }()
    
    lazy var passwordfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.layer.masksToBounds = true
        textfield.isSecureTextEntry = true
        textfield.addPadding()
        return textfield
    }()
    
    lazy var forgotpasswordbutton: UIButton = {
        let forgotpasswordbutton = UIButton()
        //forgotpasswordbutton.setTitle("Forgot Your password?", for: .normal)
        let underlineAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: logoImageColour]
        let underlineAttributedString = NSAttributedString(string: "Forgot Your password?", attributes: underlineAttribute)
        forgotpasswordbutton.setAttributedTitle(underlineAttributedString, for: .normal)
        forgotpasswordbutton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        forgotpasswordbutton.setTitleColor(logoImageColour, for: .normal)
        forgotpasswordbutton.translatesAutoresizingMaskIntoConstraints = false
        return forgotpasswordbutton
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = logoImageColour
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func login() {
        guard let email = emailfield.text else {return}
        guard let password = passwordfield.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let strongself = self else {return}
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                strongself.AlertofError("Please try again", "Our server isn't having the best time right now.")
                return
            case .userDisabled:
              // Error: The user account has been disabled by an administrator.
                strongself.AlertofError("Error", "Your account has been disabled by an administrator.")
                return
            case .wrongPassword:
              // Error: The password is invalid or the user does not have a password.
                strongself.AlertofError("Error", " Wrong password, please try again.")
                return
            case .invalidEmail:
              // Error: Indicates the email address is malformed.
                strongself.AlertofError("Please try again", "Email address is badly formatted")
                return
            default:
                print("Error: \(error.localizedDescription)")
            }
          }
            
            else {
                //check if theyre verified
                //if yes then sign in
                //if not then alert.
                
                if let authResult = authResult {
                  let user = authResult.user
                  print("User has Signed In")
                  if user.isEmailVerified {
                    print("verified")
                    strongself.dismiss(animated: true, completion: nil)
                  } else {
                    // do whatever you want to do when user isn't verified
                    print("not verified")
                    strongself.AlertofError("Whoops", "You haven't verified your email yet.")
                    }
                }
            }
        }
    }
    
    func setupView() {
        view.addSubview(LogoImage)
        view.addSubview(LoginTitle)
        view.addSubview(emailfield)
        view.addSubview(passwordfield)
        view.addSubview(forgotpasswordbutton)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            
            LogoImage.widthAnchor.constraint(equalToConstant: 100),
            LogoImage.heightAnchor.constraint(equalToConstant: 100),
            LogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            LoginTitle.topAnchor.constraint(equalTo: LogoImage.bottomAnchor, constant: 30),
            LoginTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
    
            emailfield.topAnchor.constraint(equalTo: LoginTitle.bottomAnchor, constant: 40),
            emailfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //emailfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emailfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailfield.heightAnchor.constraint(equalToConstant: 40),
            
            passwordfield.topAnchor.constraint(equalTo: emailfield.bottomAnchor, constant: 30),
            passwordfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //passwordfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            passwordfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordfield.heightAnchor.constraint(equalToConstant: 40),
            
            forgotpasswordbutton.topAnchor.constraint(equalTo: passwordfield.bottomAnchor, constant: 10),
            forgotpasswordbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //passwordfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            forgotpasswordbutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            forgotpasswordbutton.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: forgotpasswordbutton.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
}
