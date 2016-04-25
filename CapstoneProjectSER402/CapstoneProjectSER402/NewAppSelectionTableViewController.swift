//
//  NewAppSelectionTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/24/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import CoreData

class NewAppSelectionTableViewController: UITableViewController {

    
    var appNamesStrings = [String]()
    var selectedApps = [String]()
    var appAreasSelection = [BusinessArea]()
    var sysIDtoCall = [String]()
    var appAreasDidSelect = [BusinessArea]()
    var areasShown : [Bool] = []
    var areaApps = [[BusinessApp]]()
    var apps = [BusinessApp]()
    
    var appDel:AppDelegate?
    var context:NSManagedObjectContext?
    
    @IBAction func selectAllButtonPressed(sender: UIButton) {
        let section = 1
        for (var row = 0; row < tableView.numberOfRowsInSection(section); ++row) {
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.tintColor = UIColor(red: 0/255.0,
                                                                                                               green: 64/255.0,
                                                                                                               blue: 128/255.0,
                                                                                                               alpha: 1.0)
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            
        }
        selectedApps = appNamesStrings
    }
    @IBAction func clearSelectionButtonPressed(sender: UIButton) {
        let section = 1
        for (var row = 0; row < tableView.numberOfRowsInSection(section); ++row) {
            
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.accessoryType = UITableViewCellAccessoryType.None
        }
        selectedApps = []
        print(selectedApps)
        
    }
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel!.managedObjectContext
        
        callApps()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return "Options"
        } else {
            return "Apps"
        }
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return appNamesStrings.count
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("newappsoptioncell") as! NewAppsOptionTableViewCell!
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("newappscell") as! UITableViewCell!
        cell.textLabel?.text = appNamesStrings[indexPath.row]
        
        if (selectedApps.contains(appNamesStrings[indexPath.row])) {
            cell.accessoryType = .Checkmark
        } else {
            cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            let optionscell = tableView.cellForRowAtIndexPath(indexPath) as! NewAppsOptionTableViewCell!
            optionscell.selectionStyle = UITableViewCellSelectionStyle.None
            
        } else {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! UITableViewCell!
            let selectedApp = cell.textLabel!.text!
            
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

}
