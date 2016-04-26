//
//  SplashViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 4/22/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackgroundImage()
        
        // Show the home screen after a bit. Calls the show() function.
        let timer = NSTimer.scheduledTimerWithTimeInterval(
            2.5, target: self, selector: Selector("show"), userInfo: nil, repeats: false
        )
    }
    
    /*
    * Shows the app's main home screen.
    * Gets called by the timer in viewDidLoad()
    */
    func show() {
        self.performSegueWithIdentifier("showApp", sender: self)
    }
    
    /*
    * Adds background image to the splash screen
    */
    func addBackgroundImage() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let bg = UIImage(named: "splash2.png")
        let bgView = UIImageView(image: bg)
        
        bgView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
        self.view.addSubview(bgView)
    }
}