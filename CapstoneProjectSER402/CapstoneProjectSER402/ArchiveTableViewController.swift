//
//  ArchiveViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 4/2/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import Charts
import Foundation

class ArchiveTableViewController: UITableViewController, UITextFieldDelegate, ChartViewDelegate {
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    private var tickets = TicketModel()
    private var tbvc = TicketTabBarController()
    
    let closureCodes : [String] = ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
    var activeCodes : [String] = []
    var ticketStartDates = [String]()
    var selectedTF = UITextField()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    var fullTickets = [ChangeTicket]()
    var changeTickets = [ChangeTicket_Table_Template]()
    var filteredTickets = [ChangeTicket_Table_Template]()
    var sortedTickets_Time = [ChangeTicket_Table_Template]()
    var selectedApp = String()
    var selectedIndexPath : NSIndexPath?
    var isGraphSelected = false
    var cc1Tickets = Array<[ChangeTicket_Table_Template]>()
    var cc2Tickets = Array<[ChangeTicket_Table_Template]>()
    var cc3Tickets = Array<[ChangeTicket_Table_Template]>()
    var cc4Tickets = Array<[ChangeTicket_Table_Template]>()
    var cc5Tickets = Array<[ChangeTicket_Table_Template]>()
    var cc6Tickets = Array<[ChangeTicket_Table_Template]>()
    
    
    let cellIdentifier = "TicketCell"
    let appNames : [String] = []
    let DateFormat = NSDateFormatter()
    
    // Colors
    let cc1 = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let cc2 = UIColor(red: CGFloat(38/255.0), green: CGFloat(196/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let cc3 = UIColor(red: CGFloat(38/255.0), green: CGFloat(216/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let cc4 = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
    let cc5 = UIColor(red: CGFloat(237/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
    let cc6 = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 1)
    let navy = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
    let navy_comp = UIColor(red: CGFloat(51/255.0), green: CGFloat(204/255.0), blue: CGFloat(153/255.0), alpha: 1)
    
    // MARK: TextField Delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePickerView
        selectedTF = textField
        datePickerView.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        selectedTF.text = formatter.stringFromDate(sender.date)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Helper Methods
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Touch Events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closeKeyboard()
    }
    
    func loadSampleTickets() {
        DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let obj1 = ChangeTicket(number: "CHG00313717", approver: "", plannedStart: "2016-02-11 03:30:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "2016-02-11 03:30:00", actualEnd: "2016-02-11 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Low", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let obj2 = ChangeTicket(number: "CHG00314757", approver: "", plannedStart: "2016-04-25 15:05:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "2016-04-25 15:05:00", actualEnd: "2016-02-11 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Med", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let obj3 = ChangeTicket(number: "CHG00318797", approver: "", plannedStart: "2016-03-18 06:15:00", plannedEnd: "2016-03-19 08:00:00", actualStart: "2016-03-18 06:15:00", actualEnd: "2016-03-19 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "High", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let obj4 = ChangeTicket(number: "CHG00318345", approver: "", plannedStart: "2016-01-18 12:15:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "2016-01-18 12:15:00", actualEnd: "2016-02-11 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Low", type: "Emergency", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "MMA - Master Membership Application", BusinessApplicationCriticalityTier: "Tier 2")
        
        let ticket1 = ChangeTicket_Table_Template(id: obj1.getNumber(), priority: "4", startDate: DateFormat.dateFromString(obj1.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj1.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj1.getRequestedByGroupSubBusinessUnit(), closureCode: obj1.closureCode, actualEnd: obj1.actualEnd)
        let ticket2 = ChangeTicket_Table_Template(id: obj2.getNumber(), priority: "7",startDate: DateFormat.dateFromString(obj2.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj2.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj2.getRequestedByGroupSubBusinessUnit(), closureCode: obj2.closureCode, actualEnd: obj2.actualEnd)
        let ticket3 = ChangeTicket_Table_Template(id: obj3.getNumber(), priority: "1",startDate: DateFormat.dateFromString(obj3.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj3.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj3.getRequestedByGroupSubBusinessUnit(), closureCode: obj3.closureCode, actualEnd: obj3.actualEnd)
        let ticket4 = ChangeTicket_Table_Template(id: obj4.getNumber(), priority: "5",startDate: DateFormat.dateFromString(obj4.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj4.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj4.getRequestedByGroupSubBusinessUnit(), closureCode: obj4.closureCode, actualEnd: obj4.actualEnd)
        
        fullTickets += [obj1, obj2, obj3, obj4]
        changeTickets += [ticket1, ticket2, ticket3, ticket4]
        tickets.addChangeTickets(ticket1)
        tickets.addChangeTickets(ticket2)
        tickets.addChangeTickets(ticket3)
        tickets.addChangeTickets(ticket4)
        
        for ticket in changeTickets {
            if (ticket.closureCode == "Implemented as Planned") {
                cc1Tickets.append(Array(arrayLiteral: ticket))
                activeCodes += [ticket.closureCode]
            } else if (ticket.closureCode == "Implemented with Effort") {
                cc2Tickets.append(Array(arrayLiteral: ticket))
                activeCodes += [ticket.closureCode]
            } else if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
                cc3Tickets.append(Array(arrayLiteral: ticket))
                activeCodes += [ticket.closureCode]
            } else if (ticket.closureCode == "Implemented with Issues") {
                cc4Tickets.append(Array(arrayLiteral: ticket))
                activeCodes += [ticket.closureCode]
            } else if (ticket.closureCode == "Backed Out Customer/User Impacts") {
                cc5Tickets.append(Array(arrayLiteral: ticket))
                activeCodes += [ticket.closureCode]
            } else if (ticket.closureCode == "Failed to report status") {
                cc6Tickets.append(Array(arrayLiteral: ticket))
                activeCodes += [ticket.closureCode]
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pieChartView.delegate = self
        loadSampleTickets()
        sortTimeRange()
        // Do any additional setup after loading the view.
        var values : [Double] = []
        for code in activeCodes {
            if (code == closureCodes[0]) {
                values += [Double(cc1Tickets.count)]
            } else if (code == closureCodes[1]) {
                values += [Double(cc2Tickets.count)]
            } else if (code == closureCodes[2]) {
                values += [Double(cc3Tickets.count)]
            } else if (code == closureCodes[3]) {
                values += [Double(cc4Tickets.count)]
            } else if (code == closureCodes[4]) {
                values += [Double(cc5Tickets.count)]
            } else if (code == closureCodes[5]) {
                values += [Double(cc6Tickets.count)]
            }
        }
    
        setChart(activeCodes, values: values)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isGraphSelected) {
            return filteredTickets.count
        } else {
            return changeTickets.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ArchiveTableViewCell
        let white = UIColor.whiteColor()
        var ticket : ChangeTicket_Table_Template
        
        if (isGraphSelected) {
            ticket = filteredTickets[indexPath.row] as ChangeTicket_Table_Template
        } else {
            ticket = sortedTickets_Time[indexPath.row] as ChangeTicket_Table_Template
        }
       
        // Cell Color - Based on Closure Code
        if (ticket.closureCode == "Implemented as Planned") {
            cell.ccIndicator.backgroundColor = cc1
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Implemented with Effort") {
            cell.ccIndicator.backgroundColor = cc2
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
            cell.backgroundColor = cc3
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Implemented with Issues") {
            cell.ccIndicator.backgroundColor = cc4
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Backed Out Customer/User Impacts") {
            cell.ccIndicator.backgroundColor = cc5
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Failed to report status") {
            cell.ccIndicator.backgroundColor = cc6
            cell.backgroundColor = white
            cell.ticketID.textColor = UIColor.blackColor()
        } else {
            cell.backgroundColor = navy
            cell.ticketID.textColor = UIColor.whiteColor()
        }
        
        // Cell Shadow Attributes
        cell.layer.shadowColor = white.CGColor
        cell.layer.shadowRadius = 3.5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false
        
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
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellPosition = indexPath.indexAtPosition(1)
        let delay : Double = Double(cellPosition) * 0.1
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -1000, 0, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            cell.layer.transform = CATransform3DIdentity
            }, completion: { finished in
                
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func getTimeRange() -> [NSDate] {
        var range : [NSDate] = []
        
        for ticket in fullTickets {
            let formatter = NSDateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "US_en")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let time = formatter.dateFromString(ticket.actualEnd)
            range += [time!]
        }
        return range
    }
    
    func sortTimeRange() {
        var timeRange : [NSDate] = getTimeRange()
        var stringRange : [String] = []
        let formatter = NSDateFormatter()
        let total = timeRange.count
        var sortIndex = 0
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        while ((sortIndex+1) < total) {
            let time = timeRange[sortIndex]
            let nextTime = timeRange[sortIndex + 1]
            
            if nextTime.isGreaterThan(time) {
                timeRange.removeAtIndex(sortIndex+1)
                timeRange.removeAtIndex(sortIndex)
                timeRange.insert(nextTime, atIndex: sortIndex)
                timeRange.insert(time, atIndex: sortIndex+1)
                sortIndex=0
            } else {
                sortIndex++
            }
        }
        var sortIndex2 = 0
        for time in timeRange {
            let formattedTime = formatter.stringFromDate(time)
            for ticket in changeTickets {
                if (ticket.actualEnd == formattedTime) {
                    sortedTickets_Time += [ticket]
                    print(sortedTickets_Time[sortIndex2].actualEnd)
                    sortIndex2++
                }
            }
            stringRange += [formattedTime]
        }
        print(stringRange)
    }
    
    func setChart(var dataPoints: [String], var values: [Double]) {
        pieChartView.clear()
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i, data: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Closure Code")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        let numberFormatter = NSNumberFormatter()
        
        numberFormatter.generatesDecimalNumbers = false
        pieChartData.setValueFormatter(numberFormatter)
        pieChartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        pieChartView.data = pieChartData
        
        var colors : [UIColor] = []
        for i in 0..<dataPoints.count {
            if (dataPoints[i] == "Implemented as Planned") {
                let color = cc1
                colors.append(color)
            } else if (dataPoints[i] == "Implemented with Effort") {
                let color = cc2
                colors.append(color)
            } else if (dataPoints[i] == "Backed Out No Customer/User Impacts"){
                let color = cc3
                colors.append(color)
            } else if (dataPoints[i] == "Implemented with Issues"){
                let color = cc4
                colors.append(color)
            } else if (dataPoints[i] == "Backed Out Customer/User Impacts"){
                let color = cc5
                colors.append(color)
            } else if (dataPoints[i] == "Failed to report status"){
                let color = cc6
                colors.append(color)
            }
            pieChartDataSet.colors = colors
        }
        
        // Legend Data
        pieChartView.legend.enabled = false
        pieChartView.legend.yOffset = 40
        pieChartView.legend.xOffset = 60
        pieChartView.legend.position = .RightOfChart
        pieChartView.legend.form = .Circle
        pieChartView.legend.font = UIFont(name: "Helvetica", size: 9)!
        pieChartView.legend.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pieChartView.legend.colors = [cc1, cc2, cc3, cc4, cc5, cc6]
        pieChartView.legend.labels = ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
        
//        pieChartView.extraBottomOffset = 40
        pieChartView.extraRightOffset = 130
        pieChartView.drawCenterTextEnabled = true
        pieChartView.centerAttributedText = NSAttributedString(string: "Closure Codes", attributes: [
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSFontAttributeName: NSUIFont(name: "Helvetica", size: 11)! ])
        pieChartView.drawSliceTextEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.descriptionText = ""
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseOutSine)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        isGraphSelected = true
        filteredTickets.removeAll()
        
        if (entry.data! as! String == closureCodes[0]) {
            let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = .Center
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[0], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)!])
            for ticket in changeTickets {
                if (ticket.closureCode == "Implemented as Planned") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[1]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[1], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in changeTickets {
                if (ticket.closureCode == "Implemented with Effort") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[2]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[2], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in changeTickets {
                if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[3]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[3], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in changeTickets {
                if (ticket.closureCode == "Implemented with Issues") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[4]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[4], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in changeTickets {
                if (ticket.closureCode == "Backed Out Customer/User Impacts") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[5]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[5], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in changeTickets {
                if (ticket.closureCode == "Failed to report status") {
                    filteredTickets += [ticket]
                }
            }
        }
        tableView.reloadData()
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        isGraphSelected = false
        pieChartView.centerText?.removeAll()
        tableView.reloadData()
    }
    
}
