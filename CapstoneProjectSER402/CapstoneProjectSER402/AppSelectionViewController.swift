//
//  AppSelectionViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 2/15/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppSelectionViewController: UIViewController
{
    var overlay : UIView?

    @IBAction func nextButtonPressed(sender: UIBarButtonItem)
    {
        
        view.addSubview(overlay!)
        self.performSegueWithIdentifier("segueToDashboard", sender: self)
    }
    @IBAction func logoutButtonPressed(sender: UIBarButtonItem)
    {
        self.performSegueWithIdentifier("segueToLogin", sender: self)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        overlay = UIView(frame: view.frame)
        print(overlay)
        overlay!.backgroundColor = UIColor.blackColor()
        overlay!.alpha = 0.8
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
