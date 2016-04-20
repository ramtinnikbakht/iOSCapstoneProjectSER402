
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

        print(selectedTicket.shortDescription)
        //pieChartView.delegate = self
        //lineChartView.delegate = self
        selectedTicketNumber.text = selectedTicket.number
        businessAppLabel.text = selectedTicket.BusinessApplication
        businessAppLabel.textColor = UIColor.blackColor()
        plannedStartLabel.text = selectedTicket.plannedStart
        plannedEndLabel.text = selectedTicket.plannedEnd
        changeTypeLabel.text = selectedTicket.type + " / " + selectedTicket.risk
        businessUnitLabel.text = selectedTicket.requestedByGroupBusinessUnit
        subBusinessUnitLabel.text = selectedTicket.requestedByGroupSubBusinessUnit
        businessAreaLabel.text = selectedTicket.requestedByGroupBusinessArea
        shortDescriptionLabel.text = selectedTicket.shortDescription
        
        for i in 0..<infoBackgroundCount {
            let currentBackground = self.view.viewWithTag(50+i)
            currentBackground?.backgroundColor = silver
        }
        
        
        print(selectedTicket.PartofRelease)
        configurePageControl()
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
        return sectionTitles.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isGraphSelected) {
            return filteredTickets.count
        } else {
            switch (section) {
            case 0:
                return emergencyTickets.count
            case 1:
                return highRiskTickets.count
            case 2:
                return lowRiskTickets.count
            default:
                return liveTickets.count
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        var ticket : ChangeTicket
        if (isGraphSelected) {
            ticket = filteredTickets[indexPath.row] as ChangeTicket
        } else {
            if (indexPath.section == 0) {
                ticket = emergencyTickets[indexPath.row] as ChangeTicket
            } else if (indexPath.section == 1) {
                ticket = highRiskTickets[indexPath.row] as ChangeTicket
            } else if (indexPath.section == 2) {
                ticket = lowRiskTickets[indexPath.row] as ChangeTicket
            } else {
                ticket = liveTickets[indexPath.row] as ChangeTicket
            }
        }
        if (ticket.risk == "Low") {
            cell.riskIndicator.backgroundColor = low
        } else if (ticket.risk == "High") {
            cell.riskIndicator.backgroundColor = high
        }
        let white = UIColor.whiteColor()
        cell.layer.shadowColor = white.CGColor
        cell.layer.shadowRadius = 3.5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false
        cell.ticket = ticket
        
        return cell
        
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
        (cell as! ChangeTicketTableViewCell).watchFrameChanges()
        if (cell.frame.height > 50) {
            (cell as! ChangeTicketTableViewCell).expandIndicator.image = UIImage(named: "expand_less")
        } else if (cell.frame.height < 50) {
            (cell as! ChangeTicketTableViewCell).expandIndicator.image = UIImage(named: "expand_more")
        }
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
    
    func configurePageControl() {
        profilePageControl.backgroundColor = charcoal
        profilePageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        profilePageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
    }
    
}