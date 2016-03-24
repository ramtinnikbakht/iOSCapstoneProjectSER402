//
//  LoginViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 1/28/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func submitButtonPressed(sender: UIButton)
    {
        self.performSegueWithIdentifier("segueToDashboard", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        */
        
        
        let usernameImageView = UIImageView()
        let usernameImage = UIImage(named: "user.png")
        usernameImageView.image = usernameImage
        usernameImageView.frame = CGRectMake(100, 0, 20, 19);
        usernameTextField.leftView = usernameImageView
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        let passwordImageView = UIImageView()
        let passwordImage = UIImage(named: "lock.png")
        passwordImageView.image = passwordImage
        passwordImageView.frame = CGRectMake(100, 0, 20, 19);
        passwordTextField.leftView = passwordImageView
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

