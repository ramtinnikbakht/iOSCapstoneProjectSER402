//
//  AppAreaSelectionTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/19/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppAreaSelectionTableViewController: UITableViewController {

    var areas = [BusinessApp]()
    var appsTitleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionService.sharedInstance.getBusiness(appUnit: "311ab55b95b38980ce51a15d3638639c")
        areas = ConnectionService.sharedInstance.businessApps
        //ConnectionService.sharedInstance.getBusiness("3df0acd82b56b000b44bd4b419da1549")
        //areas = ConnectionService.sharedInstance.businessApps
        print(areas)
        /*for area in areas {
            appsTitleArray.append(area.businessAppSys)
        }*/
        print(appsTitleArray)
        //areas = ConnectionService.sharedInstance.getBusiness(appUnit: "311ab55b95b38980ce51a15d3638639c")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //print(areas)
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
        return "App Areas"
        
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            
        let cell = tableView.dequeueReusableCellWithIdentifier("apparea") as! AppAreaTableViewCell
        cell.appAreaTitleLabel.text = areas[indexPath.row].businessApp
        
        return cell
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
