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
    private var tickets = TicketModel()
    private var apps = BusinessModel()
    var businessApps = [BusinessApp_Table_Template]()
    let cellIdentifier = "BusinessAppCell"
    let tierList = [2, 1, 0]
    
    var isShifting = false
    var isCollapsed = [false, false, false]
    var t2Section = [BusinessApp]()
    var t1Section = [BusinessApp]()
    var t0Section = [BusinessApp]()
    var liveApps = [BusinessApp]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tbvc = tabBarController as! TicketTabBarController
        
        loadSampleApps()
    }

    func loadSampleApps()
    {

        ConnectionService.sharedInstance.getBusiness(appUnit: "311ab55b95b38980ce51a15d3638639c")
        liveApps = ConnectionService.sharedInstance.businessApps
        
        for app in liveApps {
            if (app.appCriticality == "Tier 2") {
                t2Section += [app]
            } else if (app.appCriticality == "Tier 1") {
                t1Section += [app]
            } else if (app.appCriticality == "Tier 0") {
                t0Section += [app]
            }
        }
        for tier in tierList {
            var sortIndex = 0
            if (tier == 2) {
                for app in t2Section {
                    if (app.containsEmergencyTicket) {
                        t2Section.removeAtIndex(sortIndex)
                        t2Section.insert(app, atIndex: 0)
                    }
                    sortIndex++
                }
            } else if (tier == 1) {
                for app in t1Section {
                    if (app.containsEmergencyTicket) {
                        t1Section.removeAtIndex(sortIndex)
                        t1Section.insert(app, atIndex: 0)
                    }
                    sortIndex++
                }
            } else {
                for app in t0Section {
                    if (app.containsEmergencyTicket) {
                        t0Section.removeAtIndex(sortIndex)
                        t0Section.insert(app, atIndex: 0)
                    }
                    sortIndex++
                }
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tierList.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            if (isCollapsed[section]) {
                return 0
            } else {
                return t2Section.count
            }
        case 1:
            if (isCollapsed[section]) {
                return 0
            } else {
                return t1Section.count
            }
        case 2:
            if (isCollapsed[section]) {
                return 0
            } else {
                return t0Section.count
            }
        default:
            return businessApps.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BusinessAppTableViewCell
        let app : BusinessApp
        
        if (indexPath.section == 0) {
            app = t2Section[indexPath.row] as BusinessApp

//            if ((indexPath.row + 1) >= liveApps.count){
//                nextApp = BusinessApp(appId: "", businessAppSys: "", businessApp: "", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "", businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 0)
//            } else {
//                nextApp = (liveApps[indexPath.row + 1]) as BusinessApp
//            }
        } else if (indexPath.section == 1) {
            app = t1Section[indexPath.row] as BusinessApp
//            if ((indexPath.row + 1) >= t1Section.count){
//                nextApp2 = BusinessApp_Table_Template(appName: "", ticketCount: 0, containsEmergencyTicket: false, icon: icon!, appCriticality: 0)
//            } else {
//                nextApp2 = (t1Section[indexPath.row + 1]) as BusinessApp_Table_Template
//            }
//            
        } else if (indexPath.section == 2) {
            app = t0Section[indexPath.row] as BusinessApp
//            if ((indexPath.row + 1) >= t0Section.count){
//                nextApp2 = BusinessApp_Table_Template(appName: "", ticketCount: 0, containsEmergencyTicket: false, icon: icon!, appCriticality: 0)
//            } else {
//                nextApp2 = (t0Section[indexPath.row + 1]) as BusinessApp_Table_Template
//            }
//            
      } else {
            app = liveApps[indexPath.row] as BusinessApp
//            if ((indexPath.row + 1) >= businessApps.count){
//                nextApp2 = BusinessApp_Table_Template(appName: "", ticketCount: 0, containsEmergencyTicket: false, icon: icon!, appCriticality: 0)
//            } else {
//                nextApp2 = (businessApps[indexPath.row + 1]) as BusinessApp_Table_Template
//            }
//            
       }
        
//        if (app.containsEmergencyTicket) {
            cell.backgroundColor = UIColor(red: CGFloat(217/255.0), green: CGFloat(30/255.0), blue: CGFloat(24/255.0), alpha: 1)
            cell.layer.shadowRadius = 3.5
            cell.layer.shadowOpacity = 0.7
            cell.layer.shadowOffset = CGSizeZero
            cell.layer.masksToBounds = false
            cell.ticketCount.textColor = UIColor.whiteColor()
            cell.businessAppName.textColor = UIColor.whiteColor()
            
//            if (nextApp.containsEmergencyTicket) {
//                let white = UIColor.whiteColor()
//                cell.layer.shadowColor = white.CGColor
//                
//            } else {
//                let red = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
//                cell.layer.shadowColor = red.CGColor
//            }
//        } else {
            let white = UIColor.whiteColor()
            let charcoal = UIColor(red: (34/255.0), green: (34/255.0), blue: (34/255.0), alpha: 1)
            cell.backgroundColor = white
            cell.layer.shadowColor = UIColor.lightGrayColor().CGColor
            cell.layer.shadowRadius = 2.5
            cell.layer.shadowOpacity = 0.9
            cell.layer.shadowOffset = CGSizeZero
            cell.layer.masksToBounds = false
            cell.ticketCount.textColor = charcoal
            cell.businessAppName.textColor = charcoal
//        }
        cell.app = app
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
        let collapse = UIImage(named: "expand_less.png")
        let expand = UIImage(named: "expand_more.png")
        headerCell.backgroundColor = UIColor(red: (236/255.0), green: (236/255.0), blue: (236/255.0), alpha: 1)
        headerCell.appTierLabel.text = "Tier " + String(tierList[section])
        headerCell.expandSectionButton.tag = (section)
        
        if (isCollapsed[section]) {
            headerCell.expandSectionButton.setImage(expand!, forState: .Normal)
        } else {
            headerCell.expandSectionButton.setImage(collapse!, forState: .Normal)
        }
        
        return headerCell
    }
    
    @IBAction func expandSection(sender: AnyObject) {
        isCollapsed[sender.tag!] = !isCollapsed[sender.tag!];
        isShifting = true
        tableView.reloadData()
    }
    
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellPosition = indexPath.indexAtPosition(1)
        let delay : Double = Double(cellPosition) * 0.1
        
        if (isShifting) {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -1000, 0, 0)
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                cell.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
        }
         else {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 1000, 0, 0)
            cell.layer.transform = rotationTransform
            cell.tag = 20
            
            UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                cell.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
        }
        
    }
    
    // Header Animation
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (isShifting) {

        } else {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
            view.layer.transform = rotationTransform
            view.tag = 21
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                view.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAppDetail" {
            if (sender.tag == 20) {
                let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
                let detailVC:ChangeTicketTableViewController = segue.destinationViewController as! ChangeTicketTableViewController
                let app:BusinessApp
                if (indexPath.section == 0) {
                    app = t2Section[indexPath.row] as BusinessApp
                } else if (indexPath.section == 1) {
                    app = t1Section[indexPath.row] as BusinessApp
                } else if (indexPath.section == 2) {
                    app = t0Section[indexPath.row] as BusinessApp
                } else {
                    app = BusinessApp(appId: "", businessAppSys: "", businessApp: "", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "", businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 0)
                }
                
                detailVC.selectedApp = app
            }
        }
    }
        
}