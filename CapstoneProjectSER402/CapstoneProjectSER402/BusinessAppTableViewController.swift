//
//  ChangeTicketTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import QuartzCore

class BusinessAppTableViewController: UITableViewController
{
    
    // MARK: Properties
    
    
    private var tbvc = TicketTabBarController()
    private var apps = BusinessModel()
    var businessApps = [BusinessApp_Table_Template]()
    let cellIdentifier = "BusinessAppCell"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tbvc = tabBarController as! TicketTabBarController
        
        loadSampleApps()
    }

    func loadSampleApps()
    {
        let icon = UIImage(named: "circle.png")
        let obj1 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "ServiceNow Enterprise Edition", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 12, containsEmergencyTicket: true)
        let obj2 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "Allstate Application 2", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 8, containsEmergencyTicket: true)
        let obj3 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "Allstate Application 3", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 10, containsEmergencyTicket: false)
        let obj4 = BusinessApp(appId: "ServiceNow Enterprise Edition", businessAppSys: "", businessApp: "Allstate Application 4", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "",
            businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 5, containsEmergencyTicket: false)
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BusinessAppTableViewCell
        let app = businessApps[indexPath.row] as BusinessApp_Table_Template
        if (app.containsEmergencyTicket) {
            let nextApp = (businessApps[indexPath.row + 1]) as BusinessApp_Table_Template
            if (nextApp.containsEmergencyTicket) {
                let white = UIColor.whiteColor()
                cell.backgroundColor = UIColor(red: CGFloat(217/255.0), green: CGFloat(30/255.0), blue: CGFloat(24/255.0), alpha: 1)
                cell.layer.shadowColor = white.CGColor
                cell.layer.shadowRadius = 3.5
                cell.layer.shadowOpacity = 0.7
                cell.layer.shadowOffset = CGSizeZero
                cell.layer.masksToBounds = false
                cell.ticketCount.textColor = UIColor.whiteColor()
                cell.businessAppName.textColor = UIColor.whiteColor()
                app.icon = UIImage(named: "circleEmergency.png")!
            } else {
                let red = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
                cell.backgroundColor = UIColor(red: CGFloat(217/255.0), green: CGFloat(30/255.0), blue: CGFloat(24/255.0), alpha: 1)
                cell.layer.shadowColor = red.CGColor
                cell.layer.shadowRadius = 3.5
                cell.layer.shadowOpacity = 0.9
                cell.layer.shadowOffset = CGSizeZero
                cell.layer.masksToBounds = false
                cell.ticketCount.textColor = UIColor.whiteColor()
                cell.businessAppName.textColor = UIColor.whiteColor()
                app.icon = UIImage(named: "circleEmergency.png")!
            }
        } else {
            let light_gray = UIColor.lightGrayColor()
            cell.layer.shadowColor = light_gray.CGColor
            cell.layer.shadowRadius = 2.5
            cell.layer.shadowOpacity = 0.9
            cell.layer.shadowOffset = CGSizeZero
            cell.layer.masksToBounds = false
        }
        cell.app = app
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
        headerCell.backgroundColor = UIColor.lightGrayColor()
        return headerCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAppDetail" {
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let detailVC:ChangeTicketTableViewController = segue.destinationViewController as! ChangeTicketTableViewController
            let app = businessApps[indexPath.row] as BusinessApp_Table_Template
            detailVC.selectedApp = app.appName!
        }
    }
        
}