//
//  ChangeUserTypeViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/24/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import CoreData

class ChangeUserTypeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var context:NSManagedObjectContext?

    @IBAction func saveNewUserTypeButton(sender: UIButton) {
        var newUserType = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context!) as NSManagedObject
        newUserType.setValue(newSelectedUserType, forKey: "userType")
        contextSave()
        currentUserTypeLabel.text = newSelectedUserType
        let alert = UIAlertController(title: "Alert", message: "Your new user type has been saved", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func contextSave()
    {
        do
        {
            try context!.save()
        }
        catch let error as NSError
        {
            NSLog("Error adding entity. Error: \(error)")
        }
        
    }

    @IBOutlet weak var currentUserTypeLabel: UILabel!
    @IBOutlet weak var newUserTypePicker: UIPickerView!
    var userTypesPickerSource = ["ITSM", "Business/Leadership", "App Owner", "Demo"]
    var currentUserType: String = ""
    var newSelectedUserType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        do
        {
            let results:NSArray = try context!.executeFetchRequest(fetchRequest)
            
            for var i = 0; i < results.count; i++
            {
                currentUserTypeLabel.text = results[i].valueForKey("userType") as? String
            }
        }
        catch let error as NSError
        {
            //print ("in error")
            print("Could not fetch \(error), \(error.userInfo)")
        }

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
        newSelectedUserType = userTypesPickerSource[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
