//
//  SignInViewController.swift
//  Opi9
//
//  Created by kvanadev5 on 02/11/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 6
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        
        registerButton.layer.cornerRadius = 6
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /*   Button actions    */
    @IBAction func loginButtonClicked(_ sender: Any) {
        signInUser()
    }

    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
    }
 
    @IBAction func twitterButtonClicked(_ sender: Any) {
    }
    
    @IBAction func googlePlusButtonClicked(_ sender: Any) {
    }
    
    
    
    
    
    func signInUser(){
        
        let params = ["email" :emailTextField.text,
                      "password" : passwordTextField.text]
        NetworkInterface.fetchJSON(.signin, headers: params as NSDictionary?, requestCompletionHander: {(success, data, response,error) in
            
            if success == true, let data = data{
                
                
                DispatchQueue.main.async {
                    
                }
            }
        })
    }
    
}
