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
    
    var closureCodes = [String]()
    var ticketRisks = [Double]()
    var ticketStartDates = [String]()
    var selectedTF = UITextField()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    
    var fullTickets = [ChangeTicket]()
    var changeTickets = [ChangeTicket_Table_Template]()
    var filteredTickets = [ChangeTicket_Table_Template]()
    var selectedApp = String()
    var selectedIndexPath : NSIndexPath?
    var isGraphSelected = false
    var lowRiskTickets = Array<[ChangeTicket_Table_Template]>()
    var medRiskTickets = Array<[ChangeTicket_Table_Template]>()
    var highRiskTickets = Array<[ChangeTicket_Table_Template]>()
    let cellIdentifier = "TicketCell"
    let riskLevels = ["Low", "Med", "High"]
    let appNames : [String] = []
    
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
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let obj1 = ChangeTicket(number: "CHG00313717", approver: "", plannedStart: "2016-02-11 03:30:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Low", risksys: "4", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "Implemented as Planned", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj2 = ChangeTicket(number: "CHG00314757", approver: "", plannedStart: "2016-04-25 15:05:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Med", risksys: "3", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "Implemented with Issues", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj3 = ChangeTicket(number: "CHG00318797", approver: "", plannedStart: "2016-03-18 06:15:00", plannedEnd: "2016-03-19 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "High", risksys: "2", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "Implemented with Effort", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj4 = ChangeTicket(number: "CHG00318345", approver: "", plannedStart: "2016-01-18 12:15:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Low", risksys: "4", type: "Emergency", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "Failed to report status", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "MMA - Master Membership Application", BusinessApplicationCriticalityTier: "Tier 2")
        
        let ticket1 = ChangeTicket_Table_Template(id: obj1.getNumber(), priority: obj1.getRisksys(), startDate: obj1.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj1.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj1.getRequestedByGroupSubBusinessUnit(), closureCode: obj1.closureCode)
        let ticket2 = ChangeTicket_Table_Template(id: obj2.getNumber(), priority: obj2.getRisksys(),startDate: obj2.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj2.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj2.getRequestedByGroupSubBusinessUnit(), closureCode: obj2.closureCode)
        let ticket3 = ChangeTicket_Table_Template(id: obj3.getNumber(), priority: obj3.getRisksys(),startDate: obj3.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj3.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj3.getRequestedByGroupSubBusinessUnit(), closureCode: obj3.closureCode)
        let ticket4 = ChangeTicket_Table_Template(id: obj4.getNumber(), priority: obj4.getRisksys(),startDate: obj4.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj4.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj4.getRequestedByGroupSubBusinessUnit(), closureCode: obj4.closureCode)
        
        fullTickets += [obj1, obj2, obj3, obj4]
        changeTickets += [ticket1, ticket2, ticket3, ticket4]
        tickets.addChangeTickets(ticket1)
        tickets.addChangeTickets(ticket2)
        tickets.addChangeTickets(ticket3)
        tickets.addChangeTickets(ticket4)
        
        var lowIndex = 0
        for ticket in changeTickets {
            if (Int(ticket.priority) == 4) {
                lowRiskTickets.append(Array(arrayLiteral: ticket))
            }
            lowIndex++
        }
        var medIndex = 0
        for ticket in changeTickets {
            if (Int(ticket.priority) == 3) {
                changeTickets.removeAtIndex(medIndex)
                changeTickets.insert(ticket, atIndex: 0)
                medRiskTickets.append(Array(arrayLiteral: ticket))
            }
            medIndex++
        }
        var highIndex = 0
        for ticket in changeTickets {
            if (Int(ticket.priority) == 2) {
                changeTickets.removeAtIndex(highIndex)
                changeTickets.insert(ticket, atIndex: 0)
                highRiskTickets.append(Array(arrayLiteral: ticket))
            }
            highIndex++
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closureCodes += ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
        let values : [Double] = [30.0, 3.0, 3.0, 5.0, 4.0, 15.0]
        pieChartView.delegate = self

        // Do any additional setup after loading the view.
        loadSampleTickets()
        setChart(closureCodes, values: values)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeTickets.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ArchiveTableViewCell
        let ticket = changeTickets[indexPath.row] as ChangeTicket_Table_Template
       
        if ((ticket.closureCode) == "Implemented as Planned") {
            cell.backgroundColor = cc1
            let white = UIColor.whiteColor()
            cell.ticketID.textColor = white
        } else if ((ticket.closureCode) == "Implemented with Effort") {
            cell.backgroundColor = cc2
            let white = UIColor.whiteColor()
            cell.ticketID.textColor = white
        } else if ((ticket.closureCode) == "Backed Out No Customer/User Impacts") {
            cell.backgroundColor = cc3
            let white = UIColor.whiteColor()
            cell.ticketID.textColor = white
        } else if ((ticket.closureCode) == "Implemented with Issues") {
            cell.backgroundColor = cc4
            let white = UIColor.whiteColor()
            cell.ticketID.textColor = white
        } else if ((ticket.closureCode) == "Backed Out Customer/User Impacts") {
            cell.backgroundColor = cc5
            let white = UIColor.whiteColor()
            cell.ticketID.textColor = white
        } else if ((ticket.closureCode) == "Failed to report status") {
            cell.backgroundColor = cc6
            let white = UIColor.whiteColor()
            cell.ticketID.textColor = white
        } else {
            cell.backgroundColor = navy
            cell.ticketID.textColor = UIColor.whiteColor()
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
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
        pieChartData.setValueFont(UIFont(name: "Helvetica", size: 17))
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
        pieChartView.legend.position = .LeftOfChart
        pieChartView.legend.font = UIFont(name: "Helvetica", size: 8)!
        pieChartView.legend.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pieChartView.legend.colors = [cc1, cc2, cc3, cc4, cc5, cc6]
        pieChartView.legend.labels = ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
        pieChartView.legend.maxSizePercent = 0.3
        pieChartView.legend.enabled = false
        
        pieChartView.drawCenterTextEnabled = true
        pieChartView.centerAttributedText = NSAttributedString(string: "Closure Codes", attributes: [
            NSForegroundColorAttributeName: NSUIColor(red: CGFloat(228/255.0), green: CGFloat(228/255.0), blue: CGFloat(228/255.0), alpha: 1),
            NSFontAttributeName: NSUIFont(name: "Helvetica", size: 22)! ])
        pieChartView.drawSliceTextEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.descriptionText = ""
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseOutSine)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
    }
    
}
