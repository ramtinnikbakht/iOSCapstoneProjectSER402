
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
    @IBOutlet weak var selectedAppLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var profilePageControl: UIPageControl!
    
    private var tbvc = TicketTabBarController()
    private var tickets = TicketModel()
    var fullTickets = [ChangeTicket]()
    var changeTickets = [ChangeTicket_Table_Template]()
    var filteredTickets = [ChangeTicket_Table_Template]()
    var selectedIndexPath : NSIndexPath?
    var isGraphSelected = false
    var shouldAnimate = true
    var lowRiskTickets = Array<[ChangeTicket_Table_Template]>()
    var medRiskTickets = Array<[ChangeTicket_Table_Template]>()
    var highRiskTickets = Array<[ChangeTicket_Table_Template]>()
    let cellIdentifier = "TicketCell"
    let riskLevels = ["Low", "Med", "High"]
    let appNames : [String] = []
    let DateFormat = NSDateFormatter()
    var selectedApp = BusinessApp(appId: "", businessAppSys: "", businessApp: "", appCriticality: "", owner: "", ownerSys: "", businessArea: "", businessAreaSys: "", businessUnit: "", businessUnitSys: "", businessSubUnitSys: "", businessSubUnit: "", ticketCount: 0)
    
    // Colors
    let low = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let med = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 1)
    let high = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
    let navy = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
    let navy_comp = UIColor(red: CGFloat(51/255.0), green: CGFloat(204/255.0), blue: CGFloat(153/255.0), alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        lineChartView.delegate = self
        selectedAppLabel.text = selectedApp.businessApp
        configurePageControl()
        loadSampleTickets()
        
        let ticketCount = [Double(lowRiskTickets.count), Double(medRiskTickets.count), Double(highRiskTickets.count)]
        
        setPieChart(riskLevels, values: ticketCount)
    }
    
    @IBAction func pageControlUpdated(sender: AnyObject) {
        if (sender.currentPage! == 0) {
            let ticketCount = [Double(lowRiskTickets.count), Double(medRiskTickets.count), Double(highRiskTickets.count)]
            lineChartView.hidden = true
            pieChartView.hidden = false
            setPieChart(riskLevels, values: ticketCount)
        } else {
            lineChartView.hidden = false
            pieChartView.hidden = true
            
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
            
            setLineChart(stringRange, values: values)
        }
    }
    
    func loadSampleTickets() {
        DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(selectedApp.businessUnitSys)
        print(selectedApp.businessSubUnitSys)
        //print(ConnectionService.sharedInstance.getChange(reqByGrpBusUnit: "311ab55b95b38980ce51a15d3638639c", reqByGrpSubBusUnit: selectedApp.businessSubUnitSys))
        //print(ConnectionService.sharedInstance.getChange(plannedStart: "2015-11-11 00:00:00", plannedStart2: "2015-11-12 11:30:00", reqByGrpBusUnit: "311ab55b95b38980ce51a15d3638639c", reqByGrpSubBusUnit: "7817e6556fa88dc0df488a20af3ee499", psD: "1"))
        
        
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let obj1 = ChangeTicket(number: "CHG00313717", approver: "", plannedStart: "2016-02-11 03:30:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "2016-02-11 03:30:00", actualEnd: "2016-02-11 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Low", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let obj2 = ChangeTicket(number: "CHG00314757", approver: "", plannedStart: "2016-04-25 15:05:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "2016-04-25 15:05:00", actualEnd: "2016-02-11 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Med", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let obj3 = ChangeTicket(number: "CHG00318797", approver: "", plannedStart: "2016-03-18 06:15:00", plannedEnd: "2016-03-19 08:00:00", actualStart: "2016-03-18 06:15:00", actualEnd: "2016-03-19 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "High", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let obj4 = ChangeTicket(number: "CHG00318345", approver: "", plannedStart: "2016-01-18 12:15:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "2016-01-18 12:15:00", actualEnd: "2016-02-11 08:00:00", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "Low", type: "Emergency", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "MMA - Master Membership Application", BusinessApplicationCriticalityTier: "Tier 2")
        
        let ticket1 = ChangeTicket_Table_Template(id: obj1.getNumber(), priority: "4", startDate: DateFormat.dateFromString(obj1.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj1.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj1.getRequestedByGroupSubBusinessUnit(), closureCode: obj1.closureCode, actualEnd: obj1.actualEnd)
        let ticket2 = ChangeTicket_Table_Template(id: obj2.getNumber(), priority: "4",startDate: DateFormat.dateFromString(obj2.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj2.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj2.getRequestedByGroupSubBusinessUnit(), closureCode: obj2.closureCode, actualEnd: obj2.actualEnd)
        let ticket3 = ChangeTicket_Table_Template(id: obj3.getNumber(), priority: "3",startDate: DateFormat.dateFromString(obj3.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj3.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj3.getRequestedByGroupSubBusinessUnit(), closureCode: obj3.closureCode, actualEnd: obj3.actualEnd)
        let ticket4 = ChangeTicket_Table_Template(id: obj4.getNumber(), priority: "2",startDate: DateFormat.dateFromString(obj4.getPlannedStart())!, icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj4.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj4.getRequestedByGroupSubBusinessUnit(), closureCode: obj4.closureCode, actualEnd: obj4.actualEnd)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        var ticket : ChangeTicket_Table_Template
        if (isGraphSelected) {
            ticket = filteredTickets[indexPath.row] as ChangeTicket_Table_Template
        } else {
            ticket = changeTickets[indexPath.row] as ChangeTicket_Table_Template
        }
        if (Int(ticket.priority) == 4) {
            cell.riskIndicator.backgroundColor = low
        } else if (Int(ticket.priority) == 3) {
            cell.riskIndicator.backgroundColor = med
        } else if (Int(ticket.priority) == 2) {
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
        shouldAnimate = !shouldAnimate
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
    
    func setPieChart(dataPoints: [String], values: [Double]) {
        pieChartView.clear()
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i, data: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Risk Level")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        let numberFormatter = NSNumberFormatter()
        
        
        numberFormatter.generatesDecimalNumbers = false
        pieChartData.setValueFormatter(numberFormatter)
        pieChartData.setValueFont(UIFont(name: "Helvetica", size: 17))
        pieChartView.data = pieChartData
        
        
        var colors: [UIColor] = []
    
        for i in 0..<dataPoints.count {
            if (dataPoints[i] == "Low") {
                let color = low
                colors.append(color)
            } else if (dataPoints[i] == "Med") {
                let color = med
                colors.append(color)
            } else if (dataPoints[i] == "High"){
                let color = high
                colors.append(color)
            }
            pieChartDataSet.colors = colors
        }
        
        // Legend Data
        pieChartView.legend.position = .RightOfChartInside
        pieChartView.legend.font = UIFont(name: "Helvetica", size: 10)!
        pieChartView.legend.colors = [low, med, high]
        pieChartView.legend.labels = ["Low","Medium","High"]
        pieChartView.legend.enabled = true
        
        pieChartView.drawCenterTextEnabled = true
        pieChartView.drawSliceTextEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.descriptionText = ""
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseOutSine)
    }
    
    func setLineChart(dataPoints: [String], values: [Double]) {
        lineChartView.clear()
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Change Tickets")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        let numberFormatter = NSNumberFormatter()
        
        lineChartDataSet.axisDependency = .Left
        
        numberFormatter.generatesDecimalNumbers = false
        lineChartData.setValueFormatter(numberFormatter)
        lineChartData.setDrawValues(false)
        lineChartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        lineChartDataSet.setColor(navy.colorWithAlphaComponent(0.5))
        lineChartDataSet.fillAlpha = 62 / 255.0
        lineChartDataSet.setCircleColor(navy) // our circle will be dark red
        lineChartDataSet.lineWidth = 2.0
        lineChartDataSet.circleRadius = 6.0
        

        // Legend Data
        lineChartView.legend.position = .RightOfChartInside
        lineChartView.legend.font = UIFont(name: "Helvetica", size: 10)!
        lineChartView.legend.colors = [low, med, high]
        lineChartView.legend.labels = ["Low","Medium","High"]
        lineChartView.legend.enabled = true
        
        lineChartView.leftAxis.valueFormatter = numberFormatter
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.labelPosition = .Bottom
        lineChartView.descriptionText = ""
        lineChartView.extraRightOffset = 20
        lineChartView.userInteractionEnabled = false
        lineChartView.animate(yAxisDuration: 1.0, easingOption: .EaseInCubic)
        
        lineChartView.data = lineChartData
        
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
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        isGraphSelected = true
        filteredTickets.removeAll()
        
        if (entry.data! as! String == "Low") {
            let percent = Int((entry.value / Double(changeTickets.count)) * 100.0)
            pieChartView.centerAttributedText = NSAttributedString(string: (String(percent) + "%"), attributes: [
                NSForegroundColorAttributeName: NSUIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 1),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 25)! ])
            for ticket in changeTickets {
                if (Int(ticket.priority) == 4) {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == "Med") {
            let percent = Int((entry.value / Double(changeTickets.count)) * 100.0)
            pieChartView.centerAttributedText = NSAttributedString(string: (String(percent) + "%"), attributes: [
                NSForegroundColorAttributeName: NSUIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 1),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 25)! ])
            for ticket in changeTickets {
                if (Int(ticket.priority) == 3) {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == "High") {
            let percent = Int((entry.value / Double(changeTickets.count)) * 100.0)
            pieChartView.centerAttributedText = NSAttributedString(string: (String(percent) + "%"), attributes: [
                NSForegroundColorAttributeName: NSUIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 25)! ])
            for ticket in changeTickets {
                if (Int(ticket.priority) == 2) {
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
    
    func configurePageControl() {
        profilePageControl.backgroundColor = UIColor(red: (68/255.0), green: (108/255.0), blue: (179/255.0), alpha: 1)
        profilePageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        profilePageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
    }
    
}