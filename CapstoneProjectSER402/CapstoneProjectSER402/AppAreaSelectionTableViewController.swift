//
//  AppAreaSelectionTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/19/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppAreaSelectionTableViewController: UITableViewController {
    
    var usertype: String = ""

    var area3 = [BusinessApp]()
    
    var area21 = [BusinessApp]()
    var area22 = [BusinessApp]()
    
    var appsAreaArray = [String]()
    var selectedAppAreas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionService.sharedInstance.getBusiness(appArea: "06f0acd82b56b000b44bd4b419da1574")
        area3 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1504")
        area21 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1502")
        area22 = ConnectionService.sharedInstance.businessApps
        //areas.append("")
        //ConnectionService.sharedInstance.getBusiness("3df0acd82b56b000b44bd4b419da1549")
        //areas = ConnectionService.sharedInstance.businessApps
        appsAreaArray.append((area3.first?.businessArea)!)
        appsAreaArray.append((area21.first?.businessArea)!)
        appsAreaArray.append((area22.first?.businessArea)!)
        /*for area in areas {
            appsAreaArray.append(area.businessArea)
        }
        for area in areas2 {
            appsAreaArray.append(area.businessArea)
        }*/
        print(appsAreaArray)
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
        return appsAreaArray.count
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            
        let cell = tableView.dequeueReusableCellWithIdentifier("apparea") as! AppAreaTableViewCell
        cell.appAreaTitleLabel.text = appsAreaArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AppAreaTableViewCell!
        
        if selectedAppAreas.contains(cell.appAreaTitleLabel.text!) {
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            selectedAppAreas = selectedAppAreas.filter {$0 != cell.appAreaTitleLabel.text!}
            print("worked")
            print(selectedAppAreas)
        } else {
            cell.tintColor = UIColor(red: 0/255.0,
                                     green: 64/255.0,
                                     blue: 128/255.0,
                                     alpha: 1.0)
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            selectedAppAreas += [cell.appAreaTitleLabel.text!]
            
            print(selectedAppAreas)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController : AppSelectionTableViewController = segue.destinationViewController as! AppSelectionTableViewController
        destViewController.usertype = usertype
        
        
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
