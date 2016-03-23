//
//  SuggestedAppsTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/6/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class SuggestedAppsTableViewController: UITableViewController {
    
    var usertype: String = ""

    struct Sections {
        var sectionName: String!
        var sectionContents: [String]!
    }
    
    var sectionsArray = [Sections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Alert", message: "Your User Type: \(usertype)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        sectionsArray = [Sections(sectionName: "Configuration", sectionContents: ["Select All", "UnSelect All"]), Sections(sectionName: "Suggested Apps", sectionContents: ["App1", "App2", "App3", "App4", "App5", "App6", "App7"])]

        
        //setEditing(true, animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SuggestedAppsCell") as! SuggestedAppsTableViewCell!
        
        cell.appsTitleLabel.text = sectionsArray[indexPath.section].sectionContents[indexPath.row]
        cell.checkboxImage.image = UIImage(named: "unchecked-circle")
        //cell.selectionButton.tag = indexPath.row
        //cell.selectionButton.addTarget(self, action: "selectionAction", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return sectionsArray.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sectionsArray[section].sectionContents.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionsArray[section].sectionName
    }
    
    /*override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SuggestedAppsTableViewCell!
        cell.checkboxImage.image = UIImage(named: "checked-circle")
    

    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
