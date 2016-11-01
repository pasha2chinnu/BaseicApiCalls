//
//  SignUpViewController.swift
//  Opi9
//
//  Created by kvanadev5 on 27/10/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signupUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func signupUser() {
//    Opi9ApiCalls.sharedInstance.signUpUser()
        let params = [ "firstname":"new",
                       "lastname": "user",
                       "email": "user@new.com",
                       "password": "1234",
                       "phone": "890765478",
                       "usertypereg": "yes",
                       "gender": "male"
        ]
        
        NetworkInterface.fetchJSON(.signup, headers: nil, payload: params, requestCompletionHander: {(success, data, response,error) in
            if success == true, let data = data{
               
                
                
                DispatchQueue.main.async {
                    
                }
            }
        })
        
    
    
    }
}
