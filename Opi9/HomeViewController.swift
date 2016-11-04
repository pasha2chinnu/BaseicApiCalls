//
//  HomeViewController.swift
//  Opi9
//
//  Created by kvanadev5 on 04/11/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        listAllUsers()
    }

    func listAllUsers(){
        
    }

}
