//
//  NewAppAreaSelectionTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/24/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class NewAppAreaSelectionTableViewController: UITableViewController {
    
    var appsAreaArray = [String]()
    var busArea = [BusinessArea]()
    var selectedAppAreas = [String]()
    var selectedAreas = [BusinessArea]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        ConnectionService.sharedInstance.getBusinessArea()
        busArea = ConnectionService.sharedInstance.areaList
        
        for area in busArea
        {
            appsAreaArray.append(area.getName())
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "App Areas"
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ConnectionService.sharedInstance.areaList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newapparea", forIndexPath: indexPath)

        cell.textLabel?.text = appsAreaArray[indexPath.row]
        if (selectedAppAreas.contains(appsAreaArray[indexPath.row])) {
            cell.accessoryType = .Checkmark
        } else {
            cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            cell.accessoryType = .None
        }
        return cell


        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! UITableViewCell!
        let selectedArea = cell.textLabel?.text
        
        if (selectedAppAreas.contains(selectedArea!)) {
            selectedAppAreas = selectedAppAreas.filter {$0 != cell.textLabel?.text!}
            cell.accessoryType = .None
        } else {
            cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedAppAreas.append(selectedArea!)
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
