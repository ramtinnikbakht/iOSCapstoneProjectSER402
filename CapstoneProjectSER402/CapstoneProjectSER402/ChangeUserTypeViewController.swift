//
//  ChangeUserTypeViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/24/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class ChangeUserTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var currentUserTypeLabel: UILabel!
    @IBOutlet weak var newUserTypePicker: UIPickerView!
    var userTypesPickerSource = ["ITSM", "Business/Leadership", "App Owner"]
    var currentUserType: String = ""
    var newSelectedUserType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newSelectedUserType = userTypesPickerSource[newUserTypePicker.selectedRowInComponent(0)]
        self.newUserTypePicker.dataSource = self
        self.newUserTypePicker.delegate = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypesPickerSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypesPickerSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
            newSelectedUserType = userTypesPickerSource[0]
        }
        else if (row == 1) {
            newSelectedUserType = userTypesPickerSource[1]
        }
        else if (row == 2) {
            newSelectedUserType = userTypesPickerSource[2]
        }
        else {
            print("No new user type was selected")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
