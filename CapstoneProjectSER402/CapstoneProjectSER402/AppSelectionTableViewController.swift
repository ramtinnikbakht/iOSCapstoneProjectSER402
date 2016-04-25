//
//  SuggestedAppsTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/6/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import CoreData

class AppSelectionTableViewController: UITableViewController {
    
    
    var usertype: String = ""
    var appAreasSelection = [BusinessArea]()
    var appAreasDidSelect = [BusinessArea]()
    var appNamesStrings = [String]()
    var sysIDtoCall = [String]()
    var areasShown : [Bool] = []

    var areaApps = [[BusinessApp]]()
    
    var apps = [BusinessApp]()
    //var appsArray: [String] = ["Area1App1", "Area1App2", "Area1App3", "Area2App1", "Area2App2", "Area3App1", "Area3App2", "Area3App3", "Area3App4"]
    var selectedApps = [String]()
    var appDel:AppDelegate?
    var context:NSManagedObjectContext?
    var selectedAppsArray = [BusinessApp]()

    //var mockApps = [String]()
    /*struct Sections {
        var sectionName: String!
        var sectionContents: [String]!
    }*/
    
    //var sectionsArray = [Sections]()
    
  
    @IBAction func selectAllButtonPressed(sender: UIButton) {
        let section = 2
        for (var row = 0; row < tableView.numberOfRowsInSection(section); ++row) {
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            
        }
        selectedApps = appNamesStrings
        //print(selectedApps)
        //selectedApps = mockApps
        //print(selectedApps)
    }
    
    @IBAction func clearSelectionButtonPressed(sender: UIButton) {
        let section = 2
        for (var row = 0; row < tableView.numberOfRowsInSection(section); ++row) {
            
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.accessoryType = UITableViewCellAccessoryType.None
        }
        selectedApps = []
        print(selectedApps)
    }

    
    /*func application(application: UIApplication!, performFetchWithCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
        loadApps() {
            completionHandler(UIBackgroundFetchResult.NewData)
            print(self.apps.count)
        }
    }
    
    func loadApps(completionHandler: (() -> Void)!) {
        
        completionHandler()
    }*/
    
    func callApps()
    {
        sysIDtoCall.removeAll()

        for area in appAreasSelection
        {
            sysIDtoCall += [area.getSysID()]
            appAreasDidSelect += [area]
        }
        
        for sysID in sysIDtoCall
        {
            var appsForArea = [BusinessApp]()
            ConnectionService.sharedInstance.getBusiness(appArea: sysID)
            appsForArea = ConnectionService.sharedInstance.businessApps
            let shown = [Bool](count: appsForArea.count, repeatedValue: false)
            areasShown = shown
            areaApps += [appsForArea]
        }
        
        for area in areaApps
        {
            for app in area
            {
                appNamesStrings += [app.businessApp]
                apps += [app]
            }
        }
    }

    var areas = [BusinessApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel!.managedObjectContext
        
        callApps()
        print(usertype)
        
        
        /*
        for (var q = 0; q<apps.count;q++)
        {
            if apps[q].getBusinessUnit().isEmpty
            {
                print("Not Applicable")
            }
            else
            {
                print(apps[q].getBusinessUnit())
            }
            print(apps[q].getOwner())
            //print(apps[q].getBusinessUnit())
            print(apps[q].getBusinessArea())
            print(apps[q].getBusinessAppSys())
            print(apps[q].getBusinessApp())
            print(apps[q].getAppCriticality())
            print("----------------------------")
        }
        */
        // TODO: Add if statement and logic to check for the app areas selected and grabbing apps only based on those selections
        
        /*if appAreasSelection.contains("Area1") {
            mockApps.append(appsArray[0])
            mockApps.append(appsArray[1])
            mockApps.append(appsArray[2])
            
        }
        if appAreasSelection.contains("Area2") {
            mockApps.append(appsArray[3])
            mockApps.append(appsArray[4])
            
        }
        if appAreasSelection.contains("Area3") {
            mockApps.append(appsArray[5])
            mockApps.append(appsArray[6])
            mockApps.append(appsArray[7])
            mockApps.append(appsArray[8])
            
        }
        */
        /*for app in apps {
            appsTitleArray.append(app.businessSubUnit)
            print("app title: \(appsTitleArray)")
            
        }*/
        
        //setEditing(true, animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        //userTypeLabel.text = usertype
        /*let alert = UIAlertController(title: "Alert", message: "Your User Type: \(usertype)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)*/
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("usertypecell") as! UserTypeTableViewCell!
            
            cell.userTypeLabel.text = usertype
            
            return cell!
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("appsoptioncell") as! AppsOptionTableViewCell!
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("appscell") as! AppSelectionTableViewCell!
        cell.appsTitleLabel.text = appNamesStrings[indexPath.row]
        
        if (selectedApps.contains(appNamesStrings[indexPath.row])) {
            cell.accessoryType = .Checkmark
        } else {
            cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            cell.accessoryType = .None
        }
        
        let lightGrey = UIColor.lightGrayColor()
        cell.layer.shadowColor = lightGrey.CGColor
        cell.layer.shadowRadius = 1.5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {

        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        //return apps.count
        return appNamesStrings.count
        
        //return sectionsArray[section].sectionContents.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return "User Type"
        }
        if section == 1 {
            return "Options"
        } else {
            return "Apps"
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 17.0
        } else if section == 2 {
            return 17.0
        }
        return 30.0
    }
    /*override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0
        {
            let usertypecell = tableView.cellForRowAtIndexPath(indexPath) as! UserTypeTableViewCell!
            usertypecell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        else if indexPath.section == 1
        {
            let optionscell = tableView.cellForRowAtIndexPath(indexPath) as! AppsOptionTableViewCell!
            optionscell.selectionStyle = UITableViewCellSelectionStyle.None
            
        }
        else
        {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! AppSelectionTableViewCell!
            let selectedApp = cell.appsTitleLabel.text!
            
            if (selectedApps.contains(selectedApp))
            {
                selectedApps = selectedApps.filter {$0 != selectedApp}
                cell.accessoryType = .None
            }
            else
            {
                cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                selectedApps += [selectedApp]
            }
        }
    }
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (areasShown.count != 0) {
            if (areasShown[indexPath.row] == false) {
                let cellPosition = indexPath.indexAtPosition(1)
                var delay : Double = Double(cellPosition) * 0.1
                
                if (delay >= 1.2) {
                    delay = 0
                }
                
                let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
                cell.layer.transform = rotationTransform
                
                UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                    cell.layer.transform = CATransform3DIdentity
                    }, completion: { finished in
                        
                })
                areasShown[indexPath.row] = true
            }
        }
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
    
    func saveToCoreData()
    {
        saveUserType(usertype)
        for appAreas in appAreasDidSelect
        {
            saveABusinessArea(appAreas)
        }
        for anApp in selectedAppsArray
        {
            saveABusinessApp(anApp)
        }
    }
    
    func saveABusinessApp(appObj: BusinessApp)
    {
        let newBusinessApp = NSEntityDescription.insertNewObjectForEntityForName("BusinessApps", inManagedObjectContext: context!) as NSManagedObject
        
        if appObj.getBusinessUnit().isEmpty
        {
            newBusinessApp.setValue("Not Applicable", forKey: "businessUnit")
        }
        else
        {
            newBusinessApp.setValue(appObj.getBusinessUnit(), forKey: "businessUnit")
        }
        if appObj.getBusinessArea().isEmpty
        {
            newBusinessApp.setValue("Not Applicable", forKey: "businessArea")
        }
        else
        {
            newBusinessApp.setValue(appObj.getBusinessArea(), forKey: "businessArea")
        }
        
        newBusinessApp.setValue(appObj.getBusinessApp(), forKey: "businessApp")
        newBusinessApp.setValue(appObj.getBusinessAppSys(), forKey: "businessAppSys")
        newBusinessApp.setValue(appObj.getAppCriticality(), forKey: "appCriticality")
        contextSave()
    }
    func saveABusinessArea(areaObj: BusinessArea)
    {
        var newBusinessArea = NSEntityDescription.insertNewObjectForEntityForName("BusinessArea", inManagedObjectContext: context!) as NSManagedObject
        newBusinessArea.setValue(areaObj.getName(), forKey: "busArea")
        newBusinessArea.setValue(areaObj.getSysID(), forKey: "sysID")
        contextSave()
    }
    
    func saveUserType(userTypeToSave: String)
    {
        var newUserType = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context!) as NSManagedObject
        newUserType.setValue(userTypeToSave, forKey: "userType")
        contextSave()
    }
    
    func resetCoreData(entityToDelete: String)
    {
        let selectRequest = NSFetchRequest(entityName: entityToDelete)
        do{
            let results = try context!.executeFetchRequest(selectRequest)
            if results.count > 0
            {
                for var j = 0;j < results.count; j++
                {
                    context!.deleteObject(results[j] as! NSManagedObject)
                    try context?.save()
                }
            }
        }
        catch let error as NSError{
            NSLog("error selecting all \(entityToDelete). Error \(error)")
        }
    }
    
    func saveSelectedApps()
    {
        selectedAppsArray.removeAll()
        //print("in Save  selectede apps func")
        for(var j = 0; j<selectedApps.count;j++)
        {
            //print("in first for loop")
            for(var k = 0;k<apps.count;k++)
            {
                if selectedApps[j] == apps[k].getBusinessApp()
                {
                    selectedAppsArray.append(apps[k])
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toSplashScreen"
        {
            let destViewController : SplashViewController = segue.destinationViewController as! SplashViewController
            saveSelectedApps()
            saveToCoreData()
            
            /*
            //var managedOBJ = [NSManagedObject]()
            let fetchRequest = NSFetchRequest(entityName: "BusinessApps")
            do
            {
                let results:NSArray = try context!.executeFetchRequest(fetchRequest)
                //managedOBJ = try context!.executeFetchRequest(fetchRequest) as! [NSManagedObject]
                for var i = 0; i < results.count; i++
                {
                    print(results[i].valueForKey("businessUnit"))
                    print(results[i].valueForKey("businessArea"))
                    print(results[i].valueForKey("businessAppSys"))
                    print(results[i].valueForKey("businessApp"))
                    print(results[i].valueForKey("appCriticality"))
                    
                    //print(managedOBJ[i].valueForKey("businessApp"))
                    //print(managedOBJ[i].valueForKey("appCriticality"))
                }
            }
            catch let error as NSError
            {
                //print ("in error")
                print("Could not fetch \(error), \(error.userInfo)")
            }
            */

        }
                
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
