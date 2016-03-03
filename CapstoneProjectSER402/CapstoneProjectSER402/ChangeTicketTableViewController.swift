//
//  ChangeTicketTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class ChangeTicketTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var changeTickets = [ChangeTicket_Table_Template]()
    let cellIdentifier = "ChangeTicketTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleTickets()
    }
    
    func iconTapped(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            let location = sender.locationInView(self.tableView)
            let indexPath = self.tableView.indexPathForRowAtPoint(location)
            print(changeTickets[(indexPath?.row)!].icon)
            if changeTickets[(indexPath?.row)!].isWatched == false {
                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_clicked.png")!
            } else {
                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_unclicked.png")!
            }
            self.tableView.reloadData()
            changeTickets[(indexPath?.row)!].isWatched = !changeTickets[(indexPath?.row)!].isWatched
        }
    }
    
    func loadSampleTickets() {
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let obj1 = ChangeTicket(number: "CHG00313717", approver: "", plannedStart: "2016-02-11 02:00:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "4", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj2 = ChangeTicket(number: "CHG00314757", approver: "", plannedStart: "2016-02-11 02:00:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "8", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj3 = ChangeTicket(number: "CHG00318797", approver: "", plannedStart: "2016-02-11 02:00:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "2", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let ticket1 = ChangeTicket_Table_Template(id: obj1.getNumber(), priority: obj1.getRisk(), icon: eyeIcon!, isWatched: false)
        let ticket2 = ChangeTicket_Table_Template(id: obj2.getNumber(), priority: obj2.getRisk(), icon: eyeIcon!, isWatched: false)
        let ticket3 = ChangeTicket_Table_Template(id: obj3.getNumber(), priority: obj3.getRisk(), icon: eyeIcon!, isWatched: false)
        let ticket4 = ChangeTicket_Table_Template(id: "CHG-004", priority: "5", icon: eyeIcon!, isWatched: false)
    
        //let ticket2 = ChangeTicket()
        //let ticket3 = ChangeTicket()
        //let ticket4 = ChangeTicket()
        
        changeTickets += [ticket1, ticket2, ticket3, ticket4]
        //changeTickets += [ticket1]
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
        return changeTickets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let recognizer = UITapGestureRecognizer(target: self, action: "iconTapped:")
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        let ticket = changeTickets[indexPath.row] as ChangeTicket_Table_Template
        cell.ticket = ticket
        cell.addGestureRecognizer(recognizer)
        
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
