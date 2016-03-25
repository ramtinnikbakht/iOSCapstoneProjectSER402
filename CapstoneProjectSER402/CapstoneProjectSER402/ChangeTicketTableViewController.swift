//
//  ChangeTicketTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import QuartzCore

class ChangeTicketTableViewController: UITableViewController
{
    
    // MARK: Properties
   
 
    private var tbvc = TicketTabBarController()
    private var apps = BusinessModel()
    var businessApps = [BusinessApp_Table_Template]()
    let cellIdentifier = "ChangeTicketTableViewCell"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tbvc = tabBarController as! TicketTabBarController
        //tickets = tbvc.wTickets
        
        loadSampleTickets()
    }
    
//    func iconTapped(sender: UITapGestureRecognizer)
//    {
//        if sender.state == .Ended
//        {
//            let location = sender.locationInView(self.tableView)
//            let indexPath = self.tableView.indexPathForRowAtPoint(location)
//            
//            if changeTickets[(indexPath?.row)!].isWatched == false {
//                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_clicked.png")
//                let watchedTicket = WatchedTicket(id: changeTickets[(indexPath?.row)!].id, startDate: changeTickets[(indexPath?.row)!].startDate, priority: changeTickets[(indexPath?.row)!].priority, requestedByGroupBusinessUnit: changeTickets[(indexPath?.row)!].requestedByGroupBusinessUnit, requestedByGroupSubBusinessUnit: changeTickets[(indexPath?.row)!].requestedByGroupSubBusinessUnit)
//                tickets.addWatchedTickets(watchedTicket)
//                changeTickets[(indexPath?.row)!].isWatched = !changeTickets[(indexPath?.row)!].isWatched
//            } else {
//                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_unclicked.png")
//                tickets.removeWatchedTicket(changeTickets[(indexPath?.row)!].id!)
//                changeTickets[(indexPath?.row)!].isWatched = !changeTickets[(indexPath?.row)!].isWatched
//                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_unclicked.png")!
//            }
//            self.tableView.reloadData()
//            //watchedTicketTableViewController.tableView.reloadData()
//            
//        }
//    }
    
    func loadSampleTickets()
    {
        let icon = UIImage(named: "circle.png")
        let obj1 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "ServiceNow Enterprise Edition", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 12, containsEmergencyTicket: true)
        let obj2 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "Allstate Application 2", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 8, containsEmergencyTicket: true)
        let obj3 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "Allstate Application 3", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 10, containsEmergencyTicket: false)
        let obj4 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "Allstate Application 4", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 5, containsEmergencyTicket: true)
        
        let app1 = BusinessApp_Table_Template(appName: obj1.businessApp, ticketCount: obj1.ticketCount, containsEmergencyTicket: obj1.containsEmergencyTicket, icon: icon!)
        let app2 = BusinessApp_Table_Template(appName: obj2.businessApp, ticketCount: obj2.ticketCount, containsEmergencyTicket: obj2.containsEmergencyTicket, icon: icon!)
        let app3 = BusinessApp_Table_Template(appName: obj3.businessApp, ticketCount: obj3.ticketCount, containsEmergencyTicket: obj3.containsEmergencyTicket, icon: icon!)
        let app4 = BusinessApp_Table_Template(appName: obj4.businessApp, ticketCount: obj4.ticketCount, containsEmergencyTicket: obj4.containsEmergencyTicket, icon: icon!)
    
     
        businessApps += [app1, app2, app3, app4]
        apps.addBusinessApp(app1)
        apps.addBusinessApp(app2)
        apps.addBusinessApp(app3)
        apps.addBusinessApp(app4)
        var sortIndex = 0
        for app in businessApps {
            if (app.containsEmergencyTicket) {
                businessApps.removeAtIndex(sortIndex)
                businessApps.insert(app, atIndex: 0)
            }
            sortIndex++
        }
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessApps.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let recognizer = UITapGestureRecognizer(target: self, action: "iconTapped:")
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        let app = businessApps[indexPath.row] as BusinessApp_Table_Template
        if (app.containsEmergencyTicket) {
            let red = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
            cell.backgroundColor = UIColor(red: CGFloat(217/255.0), green: CGFloat(30/255.0), blue: CGFloat(24/255.0), alpha: 1)
            cell.layer.shadowColor = red.CGColor
            cell.layer.shadowRadius = 5.0
            cell.layer.shadowOpacity = 0.9
            cell.layer.shadowOffset = CGSizeZero
            cell.layer.masksToBounds = false
            cell.ticketCount.textColor = UIColor.whiteColor()
            cell.businessAppName.textColor = UIColor.whiteColor()
            app.icon = UIImage(named: "circleEmergency.png")!
        }
        cell.app = app
        //cell.addGestureRecognizer(recognizer)
        
        return cell
        
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
//        headerCell.backgroundColor = UIColor.blackColor()
//        print("We made it here")
//        switch (section) {
//        case 0:
//            headerCell.headerLabel.text = "Recent Activity";
//            headerCell.headerLabel.textColor = UIColor.whiteColor()
//            //return sectionHeaderView
//        default:
//            headerCell.headerLabel.text = "Other";
//        }
//        
//        return headerCell
//    }
    
    

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
