
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
    var changeTickets = [ChangeTicket_Table_Template]()
    var selectedApp = String()
    var selectedIndexPath : NSIndexPath?
    let cellIdentifier = "TicketCell"
    let DateFormat = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedAppLabel.text = selectedApp
        loadSampleTickets()
    }
    
    
    func loadSampleTickets() {
        DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let obj1 = ChangeTicket(number: "CHG00313717", approver: "", plannedStart: "2016-02-11 03:30:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "4", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj2 = ChangeTicket(number: "CHG00314757", approver: "", plannedStart: "2016-04-25 15:05:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "8", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj3 = ChangeTicket(number: "CHG00318797", approver: "", plannedStart: "2016-06-18 06:15:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "2", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let ticket1 = ChangeTicket_Table_Template(id: obj1.getNumber(), priority: obj1.getRisk(), startDate: DateFormat.dateFromString(obj1.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj1.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj1.getRequestedByGroupSubBusinessUnit())
        let ticket2 = ChangeTicket_Table_Template(id: obj2.getNumber(), priority: obj2.getRisk(),startDate: DateFormat.dateFromString(obj2.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj2.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj2.getRequestedByGroupSubBusinessUnit())
        let ticket3 = ChangeTicket_Table_Template(id: obj3.getNumber(), priority: obj3.getRisk(),startDate: DateFormat.dateFromString(obj3.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj3.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj3.getRequestedByGroupSubBusinessUnit())
        let ticket4 = ChangeTicket_Table_Template(id: "CHG00314219", priority: "5",startDate: DateFormat.dateFromString("2016-011-5 18:15:00")!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: "IS - Infrastructure", requestedByGroupSubBusinessUnit: "IS - Production Process")
        
        
        changeTickets += [ticket1, ticket2, ticket3, ticket4]
        tickets.addChangeTickets(ticket1)
        tickets.addChangeTickets(ticket2)
        tickets.addChangeTickets(ticket3)
        tickets.addChangeTickets(ticket4)

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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        let ticket = changeTickets[indexPath.row] as ChangeTicket_Table_Template
        cell.ticket = ticket
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! ChangeTicketTableViewCell).watchFrameChanges()
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! ChangeTicketTableViewCell).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [ChangeTicketTableViewCell] {
            cell.ignoreFrameChanges()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return ChangeTicketTableViewCell.expandedHeight
        } else {
            return ChangeTicketTableViewCell.defaultHeight
        }
    }
    
}