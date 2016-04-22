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

class BusinessAppTableViewController: UITableViewController, ChartViewDelegate
{
    
    // MARK: Properties
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    private var tbvc = TicketTabBarController()
    private var tickets = TicketModel()
    private var apps = BusinessModel()
    var businessApps = [BusinessApp_Table_Template]()
    let cellIdentifier = "BusinessAppCell"
    let tierList = [2, 1, 0]
    let DateFormat = NSDateFormatter()
    
    var isGraphSelected = false
    var testCounts = [Int]()
    var totTicketForUnit = [Int]()
    var filteredNumbers = [String]()
    var filteredTickets = [ChangeTicket]()
    var lowRiskTickets = [ChangeTicket]()
    var highRiskTickets = [ChangeTicket]()
    var emergencyTickets = [ChangeTicket]()
    var filteredEmergencyTickets = [ChangeTicket]()
    var lowTickets = [String]()
    var highTickets = [String]()
    var compare_window = [String]()
    var compare_tickets = [String]()
    var compare_units = [[String]]()
    var compare_distinct = [[String]]()
    var sortedTickets_Time = [ChangeTicket]()
    var plannedStartDates = [NSDate]()
    var liveTickets = [ChangeTicket]()
    var isShifting = true
    var isCollapsed = [false, false, false]
    let sectionTitles = ["Emergency", "High Risk", "Low Risk"]
    var liveApps = [BusinessApp]()
    var liveTicketsShown : [Bool] = []
    var shouldAnimate = true
    var mockData = MockData()
    
    // Colors
    let low = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let med = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 1)
    let high = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
    let navy = UIColor(red: (68/255.0), green: (108/255.0), blue: (179/255.0), alpha: 1)
    let navy_comp = UIColor(red: CGFloat(51/255.0), green: CGFloat(204/255.0), blue: CGFloat(153/255.0), alpha: 1)
    let silver = UIColor(red: CGFloat(218/255.0), green: CGFloat(223/255.0), blue: CGFloat(225/255.0), alpha: 1)
    let light_blue = UIColor(red: (228/255.0), green: (241/255.0), blue: (254/255.0), alpha: 1)
    let highlight_green = UIColor(red: CGFloat(46/255.0), green: CGFloat(204/255.0), blue: CGFloat(113/255.0), alpha: 1)
    let aqua = UIColor(red: CGFloat(129/255.0), green: CGFloat(207/255.0), blue: CGFloat(224/255.0), alpha: 1)
    let charcoal = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
    let white = UIColor.whiteColor()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        barChartView.delegate = self

        var lowRisk : [Double] = []
        var highRisk : [Double] = []
        let timeFrame = getTimeWindow()
        loadSampleApps()

        let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        for time in timeFrame {
            let span = time.characters.split{$0 == " "}.map(String.init)
            compare_window += [span[0]]
        }

        for time in compare_window {
            var lowCount = 0
            var highCount = 0
            for set in compare_distinct {
                if (set[0] == time) {
                    if (set[1] == "Low") {
                        lowCount++
                    } else if (set[1] == "High") {
                        highCount++
                    }
                }
            }
            lowRisk += [Double(lowCount)]
            highRisk += [Double(highCount)]
        }

        barChartView.clear()
        setChart(timeFrame, values: lowRisk, values2: highRisk)
        isShifting = false
    }

    func loadSampleApps()
    {
        DateFormat.locale = NSLocale(localeIdentifier: "US_en")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //let now = NSDate()
        //let time1 = DateFormat.stringFromDate(now)
        //let time2 = DateFormat.stringFromDate(now.plusHours(6))
        
        //liveTickets = mockData.parseExampleXMLFile()
        liveTickets = mockData.parseExampleXMLFileForPublic()
//        ConnectionService.sharedInstance.getChange(plannedStart: "2016-01-25 02:00:00", plannedStart2: "2016-01-25 08:30:00", psD: "1")
//        liveTickets = ConnectionService.sharedInstance.ticketList

        for ticket in liveTickets {
            let currentTime = DateFormat.dateFromString(ticket.plannedStart)
            plannedStartDates += [currentTime!]
            
            if (ticket.risk == "Low" && ticket.type != "Emergency") {
                lowRiskTickets += [ticket]
            } else if (ticket.risk == "High" && ticket.type != "Emergency") {
                highRiskTickets += [ticket]
            } else if (ticket.type == "Emergency") {
                emergencyTickets += [ticket]
            }
            
        }
        
        let total = plannedStartDates.count
        var sortIndex = 0
        while ((sortIndex+1) < total) {
            let time = plannedStartDates[sortIndex]
            let nextTime = plannedStartDates[sortIndex + 1]
            
            if nextTime.isGreaterThan(time) {
                plannedStartDates.removeAtIndex(sortIndex+1)
                plannedStartDates.removeAtIndex(sortIndex)
                plannedStartDates.insert(nextTime, atIndex: sortIndex)
                plannedStartDates.insert(time, atIndex: sortIndex+1)
                sortIndex=0
            } else {
                sortIndex++
            }
        }
        
        var ticketIndex = 0
        for ticket in liveTickets {
            let ticketDate = DateFormat.dateFromString(ticket.plannedStart)!
            let minuteString = "00"
            var hourString = String(ticketDate.hour)
            var ticketTime : String = ""

            
            if (ticketDate.hour >= 12) {
                hourString = String(ticketDate.hour - 12)
            }
            if (ticketDate.minute == 0) {
                ticketTime = hourString + ":" + minuteString
            } else if (ticketDate.minute > 0 && ticketDate.minute <= 15){
                ticketTime = hourString + ":" + "15"
            } else if (ticketDate.minute > 15 && ticketDate.minute <= 30){
                ticketTime = hourString + ":" + "30"
            } else if (ticketDate.minute > 30 && ticketDate.minute <= 45){
                ticketTime = hourString + ":" + "45"
            } else {
                ticketTime = String(ticketDate.plusHours(1)) + minuteString
            }
            
            compare_tickets += [ticketTime]
            compare_units += [[ticketTime, ticket.risk, ticket.number]]
            ticketIndex++
        }
        
        var unitIndex = 0
        compare_distinct = compare_units
        for unit in compare_units {
            if (unit[1] == "Low") {
                lowTickets += unit
            } else if (unit[1] == "High") {
                highTickets += unit
            }
        }
        for unit in compare_units {
            var unitCount = 0
            for count in compare_units {
                if (unit[0] == count[0]) {
                    unitCount++
                    if (unitCount > 1) {
                        if (testCounts.contains(unitIndex)) {
                            
                        } else {
                            testCounts += [unitIndex]
                        }
                        
                    }
                }
                unitIndex++
            }
            totTicketForUnit += [unitCount]
            unitIndex = 0
        }
        
        testCounts = testCounts.sort({ $0 > $1 })
        
        for i in 0..<compare_distinct.count {
            compare_distinct[i] += [String(totTicketForUnit[i])]
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isGraphSelected) {
            switch (section) {
            case 0:
                return filteredEmergencyTickets.count
            case 1:
                var highRiskCount = 0
                for ticket in filteredTickets {
                    if (ticket.risk == "High" && ticket.type != "Emergency") {
                        highRiskCount++
                    }
                }
                return highRiskCount
            case 2:
                var lowRiskCount = 0
                for ticket in filteredTickets {
                    if (ticket.risk == "Low" && ticket.type != "Emergency") {
                        lowRiskCount++
                    }
                }
                return lowRiskCount
            default:
                return filteredTickets.count
            }
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BusinessAppTableViewCell
        var ticket : ChangeTicket
        
        if (isGraphSelected) {
            if (indexPath.section == 0) {
                ticket = filteredEmergencyTickets[indexPath.row] as ChangeTicket
                cell.emergencyIndicator.hidden = false
                cell.emergencyIndicator.image = UIImage(named: "emergency.png")
            } else {
                ticket = filteredTickets[indexPath.row] as ChangeTicket
                cell.emergencyIndicator.hidden = true
            }
        } else {
            if (indexPath.section == 0) {
                ticket = emergencyTickets[indexPath.row] as ChangeTicket
                cell.emergencyIndicator.hidden = false
                cell.emergencyIndicator.image = UIImage(named: "emergency.png")
            } else if (indexPath.section == 1) {
                ticket = highRiskTickets[indexPath.row] as ChangeTicket
                cell.emergencyIndicator.hidden = true
            } else if (indexPath.section == 2) {
                ticket = lowRiskTickets[indexPath.row] as ChangeTicket
                cell.emergencyIndicator.hidden = true
            } else {
                ticket = liveTickets[indexPath.row] as ChangeTicket
                cell.emergencyIndicator.hidden = true
            }
        }
        
        if (ticket.risk == "Low") {
            cell.riskIndicator.backgroundColor = low
        } else if (ticket.risk == "High") {
            cell.riskIndicator.backgroundColor = high
        }
        
        let lightGrey = UIColor.lightGrayColor()
        cell.riskIndicator.layer.shadowColor = white.CGColor
        cell.riskIndicator.layer.shadowRadius = 1.5
        cell.riskIndicator.layer.shadowOpacity = 0.7
        cell.riskIndicator.layer.shadowOffset = CGSizeZero
        cell.riskIndicator.layer.masksToBounds = false
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.shadowColor = lightGrey.CGColor
        cell.layer.shadowRadius = 1.5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false
        cell.ticket = ticket
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
        let white = UIColor.whiteColor()
        var suffix = " Tickets"

        headerCell.backgroundColor = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
        headerCell.appTierLabel.text = sectionTitles[section]
        headerCell.appTierLabel.textColor = white
        if (section == 0) {
            if (emergencyTickets.count == 1) {
                suffix = " Ticket"
            }
            headerCell.currentDateHeader.text = String(emergencyTickets.count) + suffix
        } else if (section == 1) {
            if (highRiskTickets.count == 1) {
                suffix = " Ticket"
            }
            headerCell.currentDateHeader.text = String(highRiskTickets.count) + suffix
        } else {
            if (lowRiskTickets.count == 1) {
                suffix = " Ticket"
            }
            headerCell.currentDateHeader.text = String(lowRiskTickets.count) + suffix
        }
        
        headerCell.currentDateHeader.textColor = white
        
        headerCell.layer.shadowColor = white.CGColor
        headerCell.layer.shadowRadius = 1.5
        headerCell.layer.shadowOpacity = 0.7
        headerCell.layer.shadowOffset = CGSizeZero
        headerCell.layer.masksToBounds = false
        
        return headerCell
    }
    
    @IBAction func expandSection(sender: AnyObject) {
        isCollapsed[sender.tag!] = !isCollapsed[sender.tag!];
        isShifting = true
        tableView.reloadData()
    }
    
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (liveTicketsShown[indexPath.row] == false) {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0, animations: {
                cell.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
            liveTicketsShown[indexPath.row] = true
        }
    }
    
    // Header Animation
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (isShifting) {

        } else {
//            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
//            view.layer.transform = rotationTransform
//            view.tag = 21
//            
//            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
//                view.layer.transform = CATransform3DIdentity
//                }, completion: { finished in
//                    
//            })
        }
        
    }

    func getTimeWindow() -> [String] {
        var timeWindow : [String] = []
        let date = NSDate()
        let totalSegments = 19
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "US_en")
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle

        let firstHour = formatter.stringFromDate(date.minusMinutes(date.minute))
        let time1 = formatter.dateFromString(firstHour)
        for i in 0..<totalSegments {
            let interval = i * 15
            let currentTime = time1?.plusMinutes(UInt(interval))
            let cTimeStr = formatter.stringFromDate(currentTime!)
            timeWindow += [cTimeStr]
        }

        return timeWindow
    }
    
    func sortTimeRange(var range: [NSDate]) {
        var stringRange : [String] = []
        let formatter = NSDateFormatter()
        let total = range.count
        var sortIndex = 0
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        while ((sortIndex+1) < total) {
            let time = range[sortIndex]
            let nextTime = range[sortIndex + 1]
            
            if nextTime.isGreaterThan(time) {
                range.removeAtIndex(sortIndex+1)
                range.removeAtIndex(sortIndex)
                range.insert(nextTime, atIndex: sortIndex)
                range.insert(time, atIndex: sortIndex+1)
                sortIndex=0
            } else {
                sortIndex++
            }
        }
        var sortIndex2 = 0
        for time in range {
            let formattedTime = formatter.stringFromDate(time)
            for ticket in liveTickets {
                if (ticket.plannedStart == formattedTime) {
                    sortedTickets_Time += [ticket]
                    sortIndex2++
                }
            }
            stringRange += [formattedTime]
        }
    }
    
    func setChart(dataPoints: [String], values: [Double], values2: [Double]) {
        barChartView.clear()
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        var index = 0
        var dataEntry = BarChartDataEntry()
        for i in 0..<dataPoints.count {
            if (values[i] > 0) {
                dataEntry = BarChartDataEntry(value: values[i], xIndex: i, data: dataPoints[i])
                dataEntries.append(dataEntry)
                index++
            } else {
                dataEntry = BarChartDataEntry(value: values[i], xIndex: i, data: dataPoints[i])
                dataEntries.append(dataEntry)
            }
        }
        var index2 = 0
        var dataEntry2 = BarChartDataEntry()
        for i in 0..<dataPoints.count {
            if (values2[i] > 0) {
                dataEntry2 = BarChartDataEntry(value: values2[i], xIndex: i, data: dataPoints[i])
                dataEntries2.append(dataEntry2)
                index2++
            } else {
                dataEntry2 = BarChartDataEntry(value: values2[i], xIndex: i)
                dataEntries2.append(dataEntry2)
            }
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Low Risk")
        let chartDataSet2 = BarChartDataSet(yVals: dataEntries2, label: "High Risk")
        chartDataSet2.drawValuesEnabled = false
        chartDataSet.colors = [low]
        chartDataSet2.colors = [high]
        chartDataSet.highlightColor = navy_comp
        chartDataSet2.highlightColor = UIColor(red: CGFloat(255/255.0), green: CGFloat(0), blue: CGFloat(35/255.0), alpha: 1)
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet2]
        let numberFormatter = NSNumberFormatter()

        let chartData = BarChartData(xVals: dataPoints, dataSets: dataSets)
        
        numberFormatter.generatesDecimalNumbers = false
        chartDataSet.valueFormatter = numberFormatter
        chartDataSet.drawValuesEnabled = false
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.noDataTextDescription = "Data has not been selected"
        
        chartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.gridColor = UIColor.lightGrayColor()
        barChartView.leftAxis.startAtZeroEnabled = true
        barChartView.leftAxis.drawGridLinesEnabled = true
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.valueFormatter = numberFormatter
        barChartView.leftAxis.axisLineColor = UIColor.blackColor()
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.descriptionText = ""
        barChartView.data = chartData
        barChartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 7)
        barChartView.xAxis.axisLineColor = UIColor.blackColor()
        barChartView.xAxis.xOffset = 10
        
        // Legend Data
        barChartView.legend.position = .RightOfChartInside
        barChartView.legend.font = UIFont(name: "Helvetica", size: 10)!
        barChartView.legend.colors = [low, med, high]
        barChartView.legend.labels = ["Low Volume","Medium Volume","High Volume"]
        barChartView.legend.enabled = false
        
        barChartView.setVisibleXRangeMaximum(6)
        barChartView.moveViewToX(14)
        barChartView.setVisibleYRangeMaximum(20, axis: .Right)
        barChartView.backgroundColor = UIColor.whiteColor()
        barChartView.drawBordersEnabled = false
        barChartView.userInteractionEnabled = true
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .Linear)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        isGraphSelected = true
        //isShifting = true
        filteredTickets.removeAll()
        filteredEmergencyTickets.removeAll()
        filteredNumbers.removeAll()
        liveTicketsShown.removeAll()
        
        if (entry.data != nil) {
            currentDateLabel.text = String(entry.data!)
            currentDateLabel.textColor = UIColor.blackColor()
            
            let time = String(entry.data!)
            var span = time.characters.split{$0 == " "}.map(String.init)
            for set in compare_distinct {
                if (set[0] == span[0]) {
                    filteredNumbers += [set[2]]
                }
            }
            if (dataSetIndex == 0) {
                for ticket in liveTickets {
                    for number in filteredNumbers {
                        if (ticket.number == number && ticket.risk == "Low" && ticket.type != "Emergency") {
                            filteredTickets += [ticket]
                        } else if (ticket.number == number && ticket.risk == "Low" && ticket.type == "Emergency") {
                            filteredEmergencyTickets += [ticket]
                        }
                    }
                }
                let ticketShown = [Bool](count: filteredTickets.count + filteredEmergencyTickets.count, repeatedValue: false)
                liveTicketsShown = ticketShown
                tableView.reloadData()
            } else if (dataSetIndex == 1) {
                for ticket in liveTickets {
                    for number in filteredNumbers {
                        if (ticket.number == number && ticket.risk == "High" && ticket.type != "Emergency") {
                            filteredTickets += [ticket]
                        } else if (ticket.number == number && ticket.risk == "High" && ticket.type == "Emergency") {
                            filteredEmergencyTickets += [ticket]
                        }
                    }
                }
                let ticketShown = [Bool](count: filteredTickets.count + filteredEmergencyTickets.count, repeatedValue: false)
                liveTicketsShown = ticketShown
                tableView.reloadData()
            }
        }
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        isGraphSelected = false
        currentDateLabel.text = ""
        liveTicketsShown.removeAll()
        let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        tableView.reloadData()
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAppDetail" {
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let detailVC:ChangeTicketTableViewController = segue.destinationViewController as! ChangeTicketTableViewController
            let ticket:ChangeTicket
            
            if (isGraphSelected) {
                if (indexPath.section == 0) {
                    ticket = filteredEmergencyTickets[indexPath.row]
                } else {
                    print(filteredTickets)
                    ticket = filteredTickets[indexPath.row]
                }

            } else {
                if (indexPath.section == 0) {
                    ticket = emergencyTickets[indexPath.row]
                } else if (indexPath.section == 1) {
                    ticket = highRiskTickets[indexPath.row]
                } else if (indexPath.section == 2) {
                    ticket = lowRiskTickets[indexPath.row]
                } else {
                    ticket = liveTickets[indexPath.row]
                }
            }
            detailVC.selectedTicket = ticket
        }
   }
        
}