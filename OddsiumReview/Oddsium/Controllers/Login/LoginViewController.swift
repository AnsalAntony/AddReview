//
//  LoginViewController.swift
//  Oddsium
//
//  Created by Ansal Antony on 22/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpLogin()
    }
    
    func setUpLogin(){
        self.view.applyGradient(colorArray: [.darkGray, .lightGray])
        
        self.loginView.layer.cornerRadius = 10
        self.loginView.layer.masksToBounds = true
        
        self.login.layer.cornerRadius = 10
        self.login.layer.masksToBounds = true
    }
    

    @IBAction func loginClicked(_ sender: Any) {
        
        
    }
    
}

