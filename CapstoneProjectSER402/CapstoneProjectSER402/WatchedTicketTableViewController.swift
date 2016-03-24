//
//  WatchedTicketTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class WatchedTicketTableViewController: UITableViewController {
    
    var watchedTickets = [WatchedTicket]()
    let cellIdentifier = "WatchedTicketTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(watchedTickets)
        //loadSampleTickets()
    }
    
    func setWatchedTickets(ticket: WatchedTicket) {
        watchedTickets += [ticket]
        self.tableView.reloadData()
        print(watchedTickets.count)
    }
    
    func loadSampleTickets() {
        let ticket1 = WatchedTicket(id: "CHG-001", priority: 8)
        let ticket2 = WatchedTicket(id: "CHG-002", priority: 4)
        let ticket3 = WatchedTicket(id: "CHG-003", priority: 1)
        let ticket4 = WatchedTicket(id: "CHG-004", priority: 5)
        
        watchedTickets += [ticket1, ticket2, ticket3, ticket4]
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
        return watchedTickets.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WatchedTicketTableViewCell
        let ticket = watchedTickets[indexPath.row] as WatchedTicket
        cell.ticket = ticket
        print("I am here")
        
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
