//
//  SelectUserTypeViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/6/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class SelectUserTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var userTypePickerView: UIPickerView!
    var userTypesPickerSource = ["ITSM", "Business/Leadership", "App Owner"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTypePickerView.dataSource = self
        self.userTypePickerView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypesPickerSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return userTypesPickerSource[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
