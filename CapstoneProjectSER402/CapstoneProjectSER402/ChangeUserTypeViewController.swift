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
    var userTypesPickerSource = ["ITSM", "Business/Leadership", "App Owner"]
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
                //valueForKey("...") what you want to grab from that entity
                /*print(results[i].valueForKey("businessUnit"))
                print(results[i].valueForKey("businessArea"))
                print(results[i].valueForKey("businessAppSys"))
                print(results[i].valueForKey("businessApp"))
                print(results[i].valueForKey("appCriticality"))*/
                //to get as string do
                
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
