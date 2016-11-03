//
//  SignUpViewController.swift
//  Opi9
//
//  Created by kvanadev5 on 27/10/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var phonenumberTextfield: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var maleRadioButton: UIButton!
    @IBOutlet weak var femaleRadioButton: UIButton!
    @IBOutlet weak var interestedRadioButton: UIButton!
    @IBOutlet weak var notInterestedRadioButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let checkedImage = UIImage(named: "selectedButton")! as UIImage
    let uncheckedImage = UIImage(named: "unselected")! as UIImage
    var gender = String()
    var registerType = String()

    
    // Bool property
    var isCheckedWithMale: Bool = false {
        didSet{
           updateMaleButtonImage()
        }
    }
    
    var isCheckedWithFemale: Bool = false {
        didSet{
            updateFemaleButtonImage()
        }
    }
    
    // Bool property
    var isCheckedWithInterested: Bool = false {
        didSet{
            updateInterestedButtonImage()
        }
    }
    
    var isCheckedWithNotInterested: Bool = false {
        didSet{
            updateNotInterestedButtonImage()
        }
    }
    
    //update Button Image
    func updateMaleButtonImage(){
        if isCheckedWithMale == true {
            maleRadioButton.setImage(checkedImage, for: .normal)
            femaleRadioButton.setImage(uncheckedImage, for: .normal)
            isCheckedWithFemale = false
            gender = maleLabel.text!
        } else {
            maleRadioButton.setImage(uncheckedImage, for: .normal)
        }
    }
    
    //update Button Image
    func updateFemaleButtonImage(){
        if isCheckedWithFemale == true {
            femaleRadioButton.setImage(checkedImage, for: .normal)
            maleRadioButton.setImage(uncheckedImage, for: .normal)
            isCheckedWithMale = false
            gender = femaleLabel.text!
        } else {
            femaleRadioButton.setImage(uncheckedImage, for: .normal)
        }
    }
    
    //update Button Image
    func updateInterestedButtonImage(){
        if isCheckedWithInterested == true {
            interestedRadioButton.setImage(checkedImage, for: .normal)
            notInterestedRadioButton.setImage(uncheckedImage, for: .normal)
            isCheckedWithNotInterested = false
            registerType = "yes"
        } else {
            interestedRadioButton.setImage(uncheckedImage, for: .normal)
        }
    }
    
    //update Button Image
    func updateNotInterestedButtonImage(){
        if isCheckedWithNotInterested == true {
            notInterestedRadioButton.setImage(checkedImage, for: .normal)
            interestedRadioButton.setImage(uncheckedImage, for: .normal)
            isCheckedWithInterested = false
            registerType = "no"
        } else {
            notInterestedRadioButton.setImage(uncheckedImage, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        phonenumberTextfield.layer.cornerRadius = 3
        phonenumberTextfield.layer.borderWidth = 1
        phonenumberTextfield.layer.borderColor = UIColor .white.cgColor
        
        signupButton.layer.cornerRadius = 3
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor .white.cgColor

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maleRadioButtonClicked(_ sender: UIButton) {
            isCheckedWithMale = !isCheckedWithMale
    }

    @IBAction func femaleRadioButtonClicked(_ sender: UIButton) {
        isCheckedWithFemale = !isCheckedWithFemale
    }
    
    @IBAction func interestedRadioButtonAction(_ sender: Any) {
        isCheckedWithInterested = !isCheckedWithInterested
    }
 
    @IBAction func notInterestedRadioButtonAction(_ sender: Any) {
        isCheckedWithNotInterested = !isCheckedWithNotInterested
    }

    @IBAction func signUpClicked(_ sender: Any) {
        signupUser()
    }
  
    func signupUser() {
        let params = [ "firstname":firstnameTextfield.text!,
                       "lastname": lastnameTextfield.text!,
                       "email": emailTextfield.text!,
                       "password": passwordTextfield.text!,
                       "phone": phonenumberTextfield.text!,
                       "usertypereg": registerType,
                       "gender": gender
        ]
        
        NetworkInterface.fetchJSON(.signup, headers: nil, payload: params, requestCompletionHander: {(success, data, response,error) in
            if success == true, let data = data{
               
                
                
                DispatchQueue.main.async {
                    
                }
            }
        })
    }
}
