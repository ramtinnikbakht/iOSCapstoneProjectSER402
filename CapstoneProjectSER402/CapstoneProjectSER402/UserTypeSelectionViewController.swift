//
//  UserTypeSelectionViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/4/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class UserTypeSelectionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet var userTypeTextField: UITextField!
    
    var userTypes = ["ITSM", "Business Leadership", "App Owner"]
    var userTypePicker = UIPickerView()
    
    @IBAction func nextButtonTouched(sender: AnyObject) {
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTypePicker.delegate = self
        userTypePicker.dataSource = self
        userTypeTextField.inputView = userTypePicker
        
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.blueColor()//(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker")
        
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        userTypeTextField.inputView = userTypePicker
        userTypeTextField.inputAccessoryView = toolBar

        // Do any additional setup after loading the view.
    }
    
    func donePicker() {
        userTypeTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text = userTypes[row]
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row]
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
