//
//  RegisterVC.swift
//  Shopping
//
//  Created by MacBook on 5/28/19.
//  Copyright © 2019 Shakhboz. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let passTxt = passwordTxt.text else { return }
        
        if textField == confirmPassTxt {
            passCheckImg.isHidden = false
            confirmPassCheckImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        
        if passwordTxt.text == confirmPassTxt.text {
            passCheckImg.image = UIImage(named: AppImages.GreenCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.GreenCheck)
        } else {
            passCheckImg.image = UIImage(named: AppImages.RedCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.RedCheck)
        }
    }
    

    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text, email.isNoEmpty,
            let username = usernameTxt.text, username.isNoEmpty,
            let password = passwordTxt.text, password.isNoEmpty else { return }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in

            if let error = error {
                debugPrint(error)
                return
            }
            
            self.activityIndicator.stopAnimating()
            print("Succesfully register new user")
        }
    }
}
