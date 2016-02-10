//
//  ViewController.swift
//  CapstoneProjectSER402
//
//  Created by the AllState Group for The SER402 Capstone project on 1/28/16.
//  License will go here.
//  Copyright © 2016  AllState Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        */
        var usernameImageView = UIImageView()
        var usernameImage = UIImage(named: "user.png")
        usernameImageView.image = usernameImage
        usernameImageView.frame = CGRectMake(100, 0, 20, 19);
        usernameTextField.leftView = usernameImageView
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        var passwordImageView = UIImageView()
        var passwordImage = UIImage(named: "lock.png")
        passwordImageView.image = passwordImage
        passwordImageView.frame = CGRectMake(100, 0, 20, 19);
        passwordTextField.leftView = passwordImageView
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

