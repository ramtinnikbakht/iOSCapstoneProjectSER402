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
    
    var changeTickets = [ChangeTicket]()
    var watchedTicketTableViewController = WatchedTicketTableViewController()
    let cellIdentifier = "ChangeTicketTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleTickets()
    }
    
    func iconTapped(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            let location = sender.locationInView(self.tableView)
            let indexPath = self.tableView.indexPathForRowAtPoint(location)
            if changeTickets[(indexPath?.row)!].isWatched == false {
                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_clicked.png")
            } else {
                changeTickets[(indexPath?.row)!].icon = UIImage(named: "eye_unclicked.png")
            }
            self.tableView.reloadData()
            changeTickets[(indexPath?.row)!].isWatched = !changeTickets[(indexPath?.row)!].isWatched
            let watchedTicket = WatchedTicket(id: changeTickets[(indexPath?.row)!].id, priority: changeTickets[(indexPath?.row)!].priority)
            watchedTicketTableViewController.setWatchedTickets(watchedTicket)
            //watchedTicketTableViewController.tableView.reloadData()
            
        }
    }
    
    func loadSampleTickets() {
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let ticket1 = ChangeTicket(id: "CHG-001", priority: 8, icon: eyeIcon, isWatched: false)
        let ticket2 = ChangeTicket(id: "CHG-002", priority: 4, icon: eyeIcon, isWatched: false)
        let ticket3 = ChangeTicket(id: "CHG-003", priority: 1, icon: eyeIcon, isWatched: false)
        let ticket4 = ChangeTicket(id: "CHG-004", priority: 5, icon: eyeIcon, isWatched: false)
        
        changeTickets += [ticket1, ticket2, ticket3, ticket4]
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
        let ticket = changeTickets[indexPath.row] as ChangeTicket
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
