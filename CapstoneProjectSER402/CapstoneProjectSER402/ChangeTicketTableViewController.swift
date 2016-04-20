
//
//  ChangeTicketTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import Charts
import QuartzCore

class ChangeTicketTableViewController: UITableViewController, ChartViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var selectedTicketNumber: UILabel!
    @IBOutlet weak var profilePageControl: UIPageControl!
    @IBOutlet weak var plannedStartLabel: UILabel!
    @IBOutlet weak var plannedEndLabel: UILabel!
    @IBOutlet weak var changeTypeLabel: UILabel!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var businessUnitLabel: UILabel!
    @IBOutlet weak var businessAreaLabel: UILabel!
    @IBOutlet weak var businessSectionView: UIView!
    @IBOutlet weak var subBusinessUnitLabel: UILabel!
    @IBOutlet weak var businessAppLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    private var tbvc = TicketTabBarController()
    private var tickets = TicketModel()
    var fullTickets = [ChangeTicket]()
    var liveTickets = [ChangeTicket]()
    var changeTickets = [ChangeTicket_Table_Template]()
    var filteredTickets = [ChangeTicket]()
    var selectedIndexPath : NSIndexPath?
    var isGraphSelected = false
    var shouldAnimate = true
    var lowRiskTickets = [ChangeTicket]()
    var highRiskTickets = [ChangeTicket]()
    var emergencyTickets = [ChangeTicket]()
    let cellIdentifier = "TicketCell"
    let riskLevels = ["Low", "High"]
    let appNames : [String] = []
    let sectionTitles = ["Emergency", "High Risk", "Low Risk"]
    let DateFormat = NSDateFormatter()
    let infoBackgroundCount = 6
    var selectedTicket = ChangeTicket(number: "", approver: "", plannedStart: "", plannedEnd: "", actualStart: "", actualEnd: "", requestedByGroup: "", requestedByGroupBusinessArea: "", requestedByGroupBusinessUnit: "", requestedByGroupSubBusinessUnit: "", causeCompleteServiceAppOutage: "", risk: "", type: "", impactScore: "", shortDescription: "", changeReason: "", closureCode: "", ImpactedEnviroment: "", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "", BusinessApplicationCriticalityTier: "")
    let generalAttributeLabels = ["Planned Start", "Planned End", "Type", "Risk"]
    var generalAttributeValues : [String] = []
    let businessAttributeLabels = ["Application", "Area", "Unit", "Sub-Unit"]
    var businessAttributeValues : [String] = []
    
    // Colors
    let low = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let med = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 1)
    let high = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
    let navy = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
    let navy_comp = UIColor(red: CGFloat(51/255.0), green: CGFloat(204/255.0), blue: CGFloat(153/255.0), alpha: 1)
    let silver = UIColor(red: CGFloat(218/255.0), green: CGFloat(223/255.0), blue: CGFloat(225/255.0), alpha: 1)
    let light_blue = UIColor(red: (228/255.0), green: (241/255.0), blue: (254/255.0), alpha: 1)
    let charcoal = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedTicketNumber.text = selectedTicket.number
        if (selectedTicket.BusinessApplication == "element <business_Application> not found") {
            businessAppLabel.text = ""
        } else {
            businessAppLabel.text = selectedTicket.BusinessApplication
        }
        businessAppLabel.textColor = UIColor.blackColor()
        
        loadTickets()
    }
    
    @IBAction func pageControlUpdated(sender: AnyObject) {
        if (sender.currentPage! == 0) {

        } else {
            //lineChartView.hidden = false
            //pieChartView.hidden = true
            
            // X Value (Time) Setup
            var timeRange : [NSDate] = getTimeRange()
            var stringRange : [String] = []
            let formatter = NSDateFormatter()
            let total = timeRange.count
            var sortIndex = 0
            formatter.dateStyle = .ShortStyle
            
            while ((sortIndex+1) < total) {
                let time = timeRange[sortIndex]
                let nextTime = timeRange[sortIndex + 1]

                if nextTime.isLessThan(time) {
                    timeRange.removeAtIndex(sortIndex+1)
                    timeRange.removeAtIndex(sortIndex)
                    timeRange.insert(nextTime, atIndex: sortIndex)
                    timeRange.insert(time, atIndex: sortIndex+1)
                    sortIndex=0
                } else {
                    sortIndex++
                }
            }
            for time in timeRange {
                let formattedTime = formatter.stringFromDate(time)
                stringRange += [formattedTime]
            }
            
            // Y Value (Risk) Setup
            var values : [Double] = []
            for time in timeRange {
                let formatter = NSDateFormatter()
                formatter.locale = NSLocale(localeIdentifier: "US_en")
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                for ticket in fullTickets {
                    if (time.isEqual(formatter.dateFromString(ticket.plannedStart)!)) {
                        values += [2.0]
                    }
                }
            }
            
            //setLineChart(stringRange, values: values)
        }
    }
    
    func loadTickets() {
        DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        ConnectionService.sharedInstance.getChange(selectedTicket.number)
        liveTickets = ConnectionService.sharedInstance.ticketList

        if (liveTickets.count > 0) {
            generalAttributeValues += [liveTickets[0].plannedStart]
            generalAttributeValues += [liveTickets[0].plannedEnd]
            generalAttributeValues += [liveTickets[0].type]
            generalAttributeValues += [liveTickets[0].risk]
            
            if (liveTickets[0].BusinessApplication == "element <business_Application> not found") {
                businessAttributeValues += ["Not Applicable"]
            } else {
                businessAttributeValues += [liveTickets[0].BusinessApplication]
            }
            businessAttributeValues += [liveTickets[0].requestedByGroupBusinessArea]
            businessAttributeValues += [liveTickets[0].requestedByGroupBusinessUnit]
            businessAttributeValues += [liveTickets[0].requestedByGroupSubBusinessUnit]
        }
        
        for ticket in liveTickets {
            if (ticket.risk == "Low" && ticket.type != "Emergency") {
                lowRiskTickets += [ticket]
            }
        }

        for ticket in liveTickets {
            if (ticket.risk == "High" && ticket.type != "Emergency") {
                highRiskTickets += [ticket]
            }
        }
        
        for ticket in liveTickets {
            if (ticket.type == "Emergency") {
                emergencyTickets += [ticket]
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return generalAttributeValues.count
        } else {
            return businessAttributeValues.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        
        let white = UIColor.whiteColor()
        cell.layer.shadowColor = white.CGColor
        cell.layer.shadowRadius = 3.5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false
        
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = white
        } else {
            cell.backgroundColor = silver
        }
        
        if (indexPath.section == 0) {
            cell.attributeLabel.text = generalAttributeLabels[indexPath.row]
            cell.attributeValue.text = generalAttributeValues[indexPath.row]
        } else {
            cell.attributeLabel.text = businessAttributeLabels[indexPath.row]
            cell.attributeValue.text = businessAttributeValues[indexPath.row]
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("TicketHeaderCell") as! ChangeTicketHeaderCell
        let white = UIColor.whiteColor()
        
        headerCell.backgroundColor = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
        if (section == 0) {
           headerCell.attributeTypeLabel.text = "General"
        } else {
            headerCell.attributeTypeLabel.text = "Business"
        }
        
        headerCell.layer.shadowColor = white.CGColor
        headerCell.layer.shadowRadius = 1.5
        headerCell.layer.shadowOpacity = 0.7
        headerCell.layer.shadowOffset = CGSizeZero
        headerCell.layer.masksToBounds = false
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        shouldAnimate = false
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
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! ChangeTicketTableViewCell)
        if (shouldAnimate) {
            let cellPosition = indexPath.indexAtPosition(1)
            let delay : Double = Double(cellPosition) * 0.1
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -1000, 0, 0)
            
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                cell.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
        }
    }
    
    func getTimeRange() -> [NSDate] {
        var range : [NSDate] = []
        
        for ticket in fullTickets {
            let formatter = NSDateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "US_en")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let time = formatter.dateFromString(ticket.plannedStart)
            range += [time!]
        }
        
        return range
    }
    
}