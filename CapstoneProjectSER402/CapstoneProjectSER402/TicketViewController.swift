//
//  TicketViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation

class TicketViewController: UITableViewController {
    
    var changeTickets = [ChangeTicket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeTickets = [ChangeTicket(id: "001", priority: "8")]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.changeTickets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var changeTicket : ChangeTicket
        
        changeTicket = changeTickets[indexPath.row]
        
        cell.textLabel?.text = changeTicket.id
        
        return cell
    }
}