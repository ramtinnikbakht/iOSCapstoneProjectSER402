//
//  WizardSetupViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 2/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class WizardSetupViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController = UIPageViewController!()
    var pageTitles = NSArray!()
    var pageDescriptions: String = "Thanks for downloading the AllState Predictive Analytics App. With this app you will be able to keep track of apps in the AllState ecosystem, pertaining to your interests. "
    var pageUserTypes = NSArray!()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pageTitles = NSArray(objects: "Welcome", "Preview")
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SetupPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        var startVC = self.viewControllerAtIndex(0) as SetupContentViewController
        var viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height - 60)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> SetupContentViewController {
        var vcontroller: SetupContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SetupContentViewController") as! SetupContentViewController
        if ((self.pageTitles == 0) || (index >= self.pageTitles.count)) {
            return SetupContentViewController()
        }
        
        if (index == 0) {
            vcontroller.descriptionText = self.pageDescriptions as! String
            
        }
       
        
        vcontroller.titleText = self.pageTitles[index] as! String
        vcontroller.pageIndex = index
        
        return vcontroller
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vcontroller = viewController as! SetupContentViewController
        var index = vcontroller.pageIndex as! Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vcontroller = viewController as! SetupContentViewController
        var index = vcontroller.pageIndex as! Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
    
    
    
    
    
    
    
    
    
    
}
