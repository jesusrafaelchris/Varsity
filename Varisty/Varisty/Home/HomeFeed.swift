//
//  HomeFeed.swift
//  Varisty
//
//  Created by Christian Grinling on 09/11/2020.
//

import UIKit
import Firebase

class HomeFeed: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedIn()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(LogOut))
        //self.title = "Home"
    }
    
    func isLoggedIn() {
        if Auth.auth().currentUser == nil || Auth.auth().currentUser?.isEmailVerified == false {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else {
           //load the pictures
        }
    }

    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print("logout error", logoutError)
        }
        
        let landingpage = LandingPage()
        let nav = UINavigationController(rootViewController: landingpage)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
    
    @objc func LogOut() {
        do { try Auth.auth().signOut() }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)}
            let landingpage = LandingPage()
            let nav = UINavigationController(rootViewController: landingpage)
            tabBarController?.selectedIndex = 0
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
    }

}
