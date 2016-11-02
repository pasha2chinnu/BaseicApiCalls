//
//  ViewController.swift
//  Opi9
//
//  Created by kvanadev5 on 27/10/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signInUser()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func signInUser(){
        
        let params = ["email" :"niranjan@gmail.com",
                      "password" : "1"]
        NetworkInterface.fetchJSON(.signin, headers: params as NSDictionary?, requestCompletionHander: {(success, data, response,error) in
        
            if success == true, let data = data{

            
                DispatchQueue.main.async {
            
                }
            }
        })
    }
}

