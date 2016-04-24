//
//  SettingsTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/24/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController {
    
    @IBAction func pushNotificationSwitchAction(sender: AnyObject) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return "Version"
        } else if section == 1 {
            return "Profile"
        } else {
            return "Support"
        }
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("alertscell") as! AlertsTableViewCell!
            
            
            return cell
        }

        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("profilecell") as! ProfileTableViewCell!
            if indexPath.row == 0 {
                cell.profileCellTitleLabel.text = "My Apps"
                return cell
            }
            if indexPath.row == 1 {
                cell.profileCellTitleLabel.text = "Change User Type"
                return cell
            }
            
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("profilecell") as! ProfileTableViewCell!
        cell.profileCellTitleLabel.text = "Send us Feedback"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            let appSelectionTableViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("myapps") as? AppSelectionTableViewController
            self.navigationController?.pushViewController(appSelectionTableViewControllerObj!, animated: true)
        }
        if indexPath.section == 2 {
            let sendfeedbackcell = tableView.dequeueReusableCellWithIdentifier("profilecell") as! ProfileTableViewCell
            sendEmail()
            
        }
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            //mail.mailComposeDelegate = self
            mail.setToRecipients(["paul@hackingwithswift.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
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
