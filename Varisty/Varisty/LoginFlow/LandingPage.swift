//
//  LandingPage.swift
//  Varisty
//
//  Created by Christian Grinling on 10/11/2020.
//

import UIKit

class LandingPage: UIViewController {
    
    var logoColour = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
    
   lazy var LogoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "whitelogo")
        return image
    }()
    
   lazy var signupButton: SignupButton = {
        let button = SignupButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.53, green: 0.32, blue: 0.93, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(red: 0.53, green: 0.32, blue: 0.93, alpha: 1.00), for: .highlighted)
        button.setTitle("Signup", for: .normal)
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.53, green: 0.32, blue: 0.93, alpha: 1.00).cgColor
        button.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        return button
    }()
    
   lazy var loginButton: LoginButton = {
        let button = LoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00), for: .highlighted)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00).cgColor
        button.addTarget(self, action: #selector(Login), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = logoColour
        setupview()
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc func SignIn() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        let signup = SignUpPage()
        navigationController?.pushViewController(signup, animated: true)
    }
    
    @objc func Login() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        let loginpage = Loginpage()
        navigationController?.pushViewController(loginpage, animated: true)
    }
    

    func setupview() {
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(LogoImage)
        
        NSLayoutConstraint.activate([
            
            LogoImage.widthAnchor.constraint(equalToConstant: 200),
            LogoImage.heightAnchor.constraint(equalToConstant: 200),
            LogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        
            signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            signupButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            signupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        ])
    }

}

class SignupButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white : UIColor(red: 0.53, green: 0.32, blue: 0.93, alpha: 1.00)
        }
    }
}

class LoginButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white : UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
        }
    }
}


var vSpinner : UIView?
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
