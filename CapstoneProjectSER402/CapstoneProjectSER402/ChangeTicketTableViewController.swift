
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
    @IBOutlet weak var selectedAppLabel: UILabel!
    
    private var tbvc = TicketTabBarController()
    private var tickets = TicketModel()
    var changeTickets = [ChangeTicket]()
    var selectedApp = String()
    let cellIdentifier = "ChangeTicketTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedAppLabel.text = selectedApp
        //loadSampleTickets()
    }
    
    
//    func loadSampleTickets() {
//        let eyeIcon = UIImage(named: "eye_unclicked.png")
////        let ticket1 = ChangeTicket(id: "CHG-001", priority: 8, startDate: "01/16", icon: eyeIcon, isWatched: false)
////        let ticket2 = ChangeTicket(id: "CHG-002", priority: 4, startDate: "02/16", icon: eyeIcon, isWatched: false)
////        let ticket3 = ChangeTicket(id: "CHG-003", priority: 1, startDate: "03/16", icon: eyeIcon, isWatched: false)
////        let ticket4 = ChangeTicket(id: "CHG-004", priority: 5, startDate: "04/16", icon: eyeIcon, isWatched: false)
//        
//        changeTickets += [ticket1, ticket2, ticket3, ticket4]
//        tickets.addChangeTickets(ticket1)
//        tickets.addChangeTickets(ticket2)
//        tickets.addChangeTickets(ticket3)
//        tickets.addChangeTickets(ticket4)
//        
//    }
    
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
        //cell.ticket = ticket
        cell.addGestureRecognizer(recognizer)
        
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
    
}