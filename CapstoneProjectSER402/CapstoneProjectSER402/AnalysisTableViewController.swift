//
//  AnalysisTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 4/22/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import Charts
import QuartzCore

class AnalysisTableViewController: UITableViewController, UITextFieldDelegate, ChartViewDelegate {
    
    var ticketRisks = [Double]()
    var ticketStartDates = [String]()
    var daySegments = [String]()
    var timeSegments = [String]()
    var lowRiskTickets = [ChangeTicket]()
    var lowRiskCount = [Double]()
    var highRiskTickets = [ChangeTicket]()
    var highRiskCount = [Double]()
    var emergencyTickets = [ChangeTicket]()
    var filteredTickets = [ChangeTicket]()
    var filteredEmergencyTickets = [ChangeTicket]()
    var selectedHours = [UInt]()
    var selectedHourLabels = [String]()
    var selectedTF = UITextField()
    var liveTickets = [ChangeTicket]()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    var selectedDay = String()
    var mockData = MockData()
    let sectionTitles = ["High Risk", "Low Risk"]
    var isGraphSelected = false
    var isShifting = true
    let cellIdentifier = "TicketCell"
    var liveTicketsShown : [Bool] = []
    var day0Header = String()
    var day1Header = String()
    var day2Header = String()
    var day3Header = String()
    let highTicketTotal = UILabel(frame: CGRectMake(-2.5, 60, 50, 50))
    let highTicketTab = UIImageView(frame: CGRectMake(-10, 60, 60, 50))
    let lowTicketTotal = UILabel(frame: CGRectMake(327.5, 60, 50, 50))
    let lowTicketTab = UIImageView(frame: CGRectMake(325, 60, 60, 50))
    
    let DateFormat = NSDateFormatter()
    
    // Colors
    let low = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 0.4)
    let med = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 0.6)
    let high = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 0.6)
    let charcoal = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
    let white = UIColor.whiteColor()
    
    
    @IBOutlet weak var currentTimeFrameTF: UITextField!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var radarChartView: RadarChartView!
    
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timeFrameStepper: UIStepper!
    @IBOutlet weak var noTicketsIcon: UIImageView!
    
    
    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePickerView
        selectedTF = textField
        datePickerView.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
    }
    

    @IBAction func timeFrameUpdated(sender: AnyObject) {
        print("Time Frame Updated")
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
    
    @IBAction func timeIndexChanged(sender: AnyObject) {
        isGraphSelected = false
        switch timeSegmentedControl.selectedSegmentIndex
        {
        case 0:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[0]
            calculateTimeFrame(daySegments[0], counterValue: 0)
            currentDateLabel.text = day0Header
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortTicketsByRisk()
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            if (isTicketsNotEmpty(highRiskCount, lowRiskValues: lowRiskCount)) {
                noTicketsIcon.hidden = true
                setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
            } else {
                noTicketsIcon.hidden = false
                noTicketsIcon.image = UIImage(named: "EmptyGraphIcon.png")
            }
            highTicketTotal.text = highRiskTickets.count.description
            lowTicketTotal.text = lowRiskTickets.count.description
            tableView.reloadData()
        case 1:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[1]
            calculateTimeFrame(daySegments[1], counterValue: 0)
            currentDateLabel.text = day1Header
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortTicketsByRisk()
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            if (isTicketsNotEmpty(highRiskCount, lowRiskValues: lowRiskCount)) {
                noTicketsIcon.hidden = true
                setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
            } else {
                noTicketsIcon.hidden = false
                noTicketsIcon.image = UIImage(named: "EmptyGraphIcon.png")
            }
            highTicketTotal.text = highRiskTickets.count.description
            lowTicketTotal.text = lowRiskTickets.count.description
            tableView.reloadData()
        case 2:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[2]
            calculateTimeFrame(daySegments[2], counterValue: 0)
            currentDateLabel.text = day2Header
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortTicketsByRisk()
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            if (isTicketsNotEmpty(highRiskCount, lowRiskValues: lowRiskCount)) {
                noTicketsIcon.hidden = true
                setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
            } else {
                noTicketsIcon.hidden = false
                noTicketsIcon.image = UIImage(named: "EmptyGraphIcon.png")
            }
            highTicketTotal.text = highRiskTickets.count.description
            lowTicketTotal.text = lowRiskTickets.count.description
            tableView.reloadData()
        case 3:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[3]
            calculateTimeFrame(daySegments[3], counterValue: 0)
            currentDateLabel.text = day3Header
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortTicketsByRisk()
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            if (isTicketsNotEmpty(highRiskCount, lowRiskValues: lowRiskCount)) {
                noTicketsIcon.hidden = true
                setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
            } else {
                noTicketsIcon.hidden = false
                noTicketsIcon.image = UIImage(named: "EmptyGraphIcon.png")
            }
            highTicketTotal.text = highRiskTickets.count.description
            lowTicketTotal.text = lowRiskTickets.count.description
            tableView.reloadData()
        default:
            break;
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        isGraphSelected = false
        let timeFrameIndex = Int(sender.value)
        liveTickets.removeAll()

        calculateDaySegment()
        calculateTimeFrame(selectedDay, counterValue: timeFrameIndex)
        
                ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
                liveTickets = ConnectionService.sharedInstance.ticketList
        //liveTickets = mockData.MOCK_DATA_ARRAY
        sortTicketsByRisk()
        calculateGraphValues()
        radarChartView.clear()
        highTicketTotal.text = highRiskTickets.count.description
        lowTicketTotal.text = lowRiskTickets.count.description
        if (isTicketsNotEmpty(highRiskCount, lowRiskValues: lowRiskCount)) {
            noTicketsIcon.hidden = true
            setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
        } else {
            noTicketsIcon.hidden = false
            noTicketsIcon.image = UIImage(named: "EmptyGraphIcon.png")
        }
        
        tableView.reloadData()
    }
    
    func setupSegmentControl() {
        let today = DateFormat.dateFromString(daySegments[0])
        let todayLabel = convertMonthLabel(today!.month) + " " + String(today!.day)
        day0Header = todayLabel + ", " + String(today!.year)
        
        let firstDay = DateFormat.dateFromString(daySegments[1])
        let firstDayLabel = convertMonthLabel(firstDay!.month) + " " + String(firstDay!.day)
        day1Header = firstDayLabel + ", " + String(firstDay!.year)
        
        let secondDay = DateFormat.dateFromString(daySegments[2])
        let secondDayLabel = convertMonthLabel(secondDay!.month) + " " + String(secondDay!.day)
        day2Header = secondDayLabel + ", " + String(secondDay!.year)
        
        let thirdDay = DateFormat.dateFromString(daySegments[3])
        let thirdDayLabel = convertMonthLabel(thirdDay!.month) + " " + String(thirdDay!.day)
        day3Header = thirdDayLabel + ", " + String(thirdDay!.year)
        
        timeSegmentedControl.setTitle(firstDayLabel, forSegmentAtIndex: 1)
        timeSegmentedControl.setTitle(secondDayLabel, forSegmentAtIndex: 2)
        timeSegmentedControl.setTitle(thirdDayLabel, forSegmentAtIndex: 3)
    }
    
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            radarChartView.xAxis.removeLimitLine(releaseWindowLL)
            releaseWindowLL.valueTextColor = UIColor(red: (255/255.0), green: 0, blue: 0, alpha: 0.3)
            releaseWindowLL.lineColor = UIColor(red: (255/255.0), green: 0, blue: 0, alpha: 0.3)
            releaseWindowLL.valueFont = UIFont(name: "Helvetica", size: 10)!
            releaseWindowLL.labelPosition = .RightBottom
            radarChartView.xAxis.addLimitLine(releaseWindowLL)
            radarChartView.xAxis.drawLimitLinesBehindDataEnabled = true
            radarChartView.setNeedsDisplay()
        } else {
            radarChartView.xAxis.removeLimitLine(releaseWindowLL)
            radarChartView.setNeedsDisplay()
        }
    }
    
    func calculateDaySegment() {
        daySegments.removeAll()
        //let now = NSDate()
        DateFormat.locale = NSLocale(localeIdentifier: "US_en")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //let dateArr = DateFormat.stringFromDate(now)
        //let currentDate = dateArr.characters.split{$0 == " "}.map(String.init)
        let currentDate = "2016-03-10 00:00:00"
        //let dateBeginning_Now = currentDate[0] + " 00:00:00"
        let dateBeginning_Now = currentDate //+ " 00:00:00"
        let dateZero = DateFormat.dateFromString(dateBeginning_Now)
        
        let dateBeginning_24 = dateZero?.plusDays(1)
        let dateBeginning_48 = dateZero?.plusDays(2)
        let dateBeginning_72 = dateZero?.plusDays(3)
        
        daySegments += [dateBeginning_Now, DateFormat.stringFromDate(dateBeginning_24!), DateFormat.stringFromDate(dateBeginning_48!), DateFormat.stringFromDate(dateBeginning_72!)]
    }
    
    func calculateTimeFrame(dateForFrame: String, counterValue: Int) {
        timeSegments.removeAll()
        selectedHours.removeAll()
        selectedHourLabels.removeAll()
        var label : String = ""
        let date = DateFormat.dateFromString(dateForFrame)
        let timeMultiple = 6 * counterValue
        
        let time1 = UInt(timeMultiple + 1)
        let time2 = UInt(timeMultiple + 2)
        let time3 = UInt(timeMultiple + 3)
        let time4 = UInt(timeMultiple + 4)
        let time5 = UInt(timeMultiple + 5)
        let time6 = UInt(timeMultiple + 6)
        
        let timeFrame1 = date?.plusHours(time1)
        let timeFrame2 = date?.plusHours(time2)
        let timeFrame3 = date?.plusHours(time3)
        let timeFrame4 = date?.plusHours(time4)
        let timeFrame5 = date?.plusHours(time5)
        let timeFrame6 = date?.plusHours(time6)
        
        timeSegments += [DateFormat.stringFromDate(timeFrame1!), DateFormat.stringFromDate(timeFrame2!), DateFormat.stringFromDate(timeFrame3!), DateFormat.stringFromDate(timeFrame4!), DateFormat.stringFromDate(timeFrame5!), DateFormat.stringFromDate(timeFrame6!)]
        selectedHours += [time1, time2, time3, time4, time5, time6]
        
        for hour in selectedHours {
            if (Int(hour) <= 12) {
                if (Int(hour) == 12) {
                    label = String(hour) + ":00 PM"
                } else {
                    label = String(hour) + ":00 AM"
                }
                selectedHourLabels += [label]
            } else if (Int(hour) > 12) {
                let convertedTime = Int(hour) - 12
                if (convertedTime == 12) {
                    label = String(convertedTime) + ":00 AM"
                } else {
                    label = String(convertedTime) + ":00 PM"
                }
                
                selectedHourLabels += [label]
            }
        }
        
        UIView.transitionWithView(currentTimeFrameTF, duration: 0.5, options: [.TransitionFlipFromLeft], animations: {
            self.currentTimeFrameTF.text = self.selectedHourLabels[0] + " - " + self.selectedHourLabels[5]
            }, completion: nil)
        
//        let animation = CATransition()
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        animation.type = kCATransitionFromTop
//        animation.duration = 0.75
//        currentTimeFrameTF.layer.addAnimation(animation, forKey: "kCATransitionFromTop")
//        currentTimeFrameTF.text = selectedHourLabels[0] + " - " + selectedHourLabels[5]
    }
    
    func calculateGraphValues() {
        lowRiskCount.removeAll()
        highRiskCount.removeAll()
        DateFormat.locale = NSLocale(localeIdentifier: "US_en")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Low Ticket Count for Time Range
        var hour1CountLow : Int = 0
        var hour2CountLow : Int = 0
        var hour3CountLow : Int = 0
        var hour4CountLow : Int = 0
        var hour5CountLow : Int = 0
        var hour6CountLow : Int = 0
        
        // High Ticket Count for Time Range
        var hour1CountHigh : Int = 0
        var hour2CountHigh : Int = 0
        var hour3CountHigh : Int = 0
        var hour4CountHigh : Int = 0
        var hour5CountHigh : Int = 0
        var hour6CountHigh : Int = 0
        
        // Totals
        var lowTicketTotal = 0
        var highTicketTotal = 0
        
        if (liveTickets.count > 0) {
            
            for ticket in liveTickets {
                let ticketPS = DateFormat.dateFromString(ticket.plannedStart)
                if (ticketPS!.hour == selectedHours[0]) {
                    if (ticket.risk == "Low") {
                        lowTicketTotal++
                        hour1CountLow++
                    } else {
                        highTicketTotal++
                        hour1CountHigh++
                    }
                } else if (ticketPS!.hour == selectedHours[1]) {
                    if (ticket.risk == "Low") {
                        lowTicketTotal++
                        hour2CountLow++
                    } else {
                        highTicketTotal++
                        hour2CountHigh++
                    }
                } else if (ticketPS!.hour == selectedHours[2]) {
                    if (ticket.risk == "Low") {
                        lowTicketTotal++
                        hour3CountLow++
                    } else {
                        highTicketTotal++
                        hour3CountHigh++
                    }
                } else if (ticketPS!.hour == selectedHours[3]) {
                    if (ticket.risk == "Low") {
                        lowTicketTotal++
                        hour4CountLow++
                    } else {
                        highTicketTotal++
                        hour4CountHigh++
                    }
                } else if (ticketPS!.hour == selectedHours[4]) {
                    if (ticket.risk == "Low") {
                        lowTicketTotal++
                        hour5CountLow++
                    } else {
                        highTicketTotal++
                        hour5CountHigh++
                    }
                } else if (ticketPS!.hour == selectedHours[5]) {
                    if (ticket.risk == "Low") {
                        lowTicketTotal++
                        hour6CountLow++
                    } else {
                        highTicketTotal++
                        hour6CountHigh++
                    }
                }
            }
        }
        
        lowRiskCount += [Double(hour1CountLow), Double(hour2CountLow), Double(hour3CountLow), Double(hour4CountLow), Double(hour5CountLow), Double(hour6CountLow)]
        highRiskCount += [Double(hour1CountHigh), Double(hour2CountHigh), Double(hour3CountHigh), Double(hour4CountHigh), Double(hour5CountHigh), Double(hour6CountHigh)]
    }
    
    func sortTicketsByRisk() {
        lowRiskTickets.removeAll()
        highRiskTickets.removeAll()
        
        let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        
        for ticket in liveTickets {
            if (ticket.risk == "Low") {
                lowRiskTickets += [ticket]
            } else if (ticket.risk == "High") {
                highRiskTickets += [ticket]
            }
        }
    }
    
    func isTicketsNotEmpty(highRiskValues: [Double], lowRiskValues: [Double]) -> Bool {
        var emptyHighValues = 0
        var emptyLowValues = 0
        
        for value in highRiskValues {
            if (value == 0) {
                emptyHighValues++
            }
        }
        
        for value in lowRiskValues {
            if (value == 0) {
                emptyLowValues++
            }
        }
        
        if (emptyHighValues == highRiskValues.count && emptyLowValues == lowRiskValues.count) {
            return false
        } else {
            return true
        }
    }
    
    func convertMonthLabel(monthValue: UInt) -> String {
        var month = ""
        switch(monthValue) {
        case 1:
            month = "January"
        case 2:
            month = "February"
        case 3:
            month = "March"
        case 4:
            month = "April"
        case 5:
            month = "May"
        case 6:
            month = "June"
        case 7:
            month = "July"
        case 8:
            month = "August"
        case 9:
            month = "September"
        case 10:
            month = "October"
        case 11:
            month = "November"
        case 12:
            month = "December"
        default:
            month = "Nil"
        }
        return month
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radarChartView.delegate = self
        timeFrameStepper.wraps = true
        timeFrameStepper.autorepeat = false
        timeFrameStepper.maximumValue = 3
        
        highTicketTotal.textColor = UIColor.whiteColor()
        highTicketTotal.textAlignment = .Center
        highTicketTab.backgroundColor = high
        highTicketTab.layer.cornerRadius = 8.0
        highTicketTab.clipsToBounds = true
        view.addSubview(highTicketTab)
        view.addSubview(highTicketTotal)
        
        
        lowTicketTotal.textColor = UIColor.whiteColor()
        lowTicketTotal.textAlignment = .Center
        lowTicketTab.backgroundColor = low
        lowTicketTab.layer.cornerRadius = 8.0
        lowTicketTab.clipsToBounds = true
        view.addSubview(lowTicketTab)
        view.addSubview(lowTicketTotal)
        
        //currentTimeFrameTF.addTarget(self, action: "timeFrameUpdated:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view.
        calculateDaySegment()
        selectedDay = daySegments[0]
        calculateTimeFrame(daySegments[0], counterValue: 0)
        setupSegmentControl()
        currentDateLabel.text = day0Header
        //        ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
        //        liveTickets = ConnectionService.sharedInstance.ticketList
        liveTickets = mockData.parseExampleXMLFile()
        sortTicketsByRisk()
        calculateGraphValues()
        setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
        
        highTicketTotal.text = highRiskTickets.count.description
        lowTicketTotal.text = lowRiskTickets.count.description
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isGraphSelected) {
            switch (section) {
            case 0:
                var highRiskCount = 0
                for ticket in filteredTickets {
                    if (ticket.risk == "High") {
                        highRiskCount++
                    }
                }
                return highRiskCount
            case 1:
                var lowRiskCount = 0
                for ticket in filteredTickets {
                    if (ticket.risk == "Low") {
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
                return highRiskTickets.count
            case 1:
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
            ticket = filteredTickets[indexPath.row] as ChangeTicket
        } else {
            if (indexPath.section == 0) {
                ticket = highRiskTickets[indexPath.row] as ChangeTicket
            } else if (indexPath.section == 1) {
                ticket = lowRiskTickets[indexPath.row] as ChangeTicket
            } else {
                ticket = liveTickets[indexPath.row] as ChangeTicket
            }
        }
        
        if (ticket.type == "Emergency") {
            cell.emergencyIndicator.hidden = false
            cell.emergencyIndicator.image = UIImage(named: "emergency.png")
        } else {
            cell.emergencyIndicator.hidden = true
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
            if (highRiskTickets.count == 1) {
                suffix = " Ticket"
            }
            headerCell.currentDateHeader.text = String(highRiskTickets.count) + suffix
        } else if (section == 1) {
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
        //isCollapsed[sender.tag!] = !isCollapsed[sender.tag!];
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
    
    func setChart(dataPoints: [String], values: [Double], values2: [Double]) {
        radarChartView.clear()
        var dataEntries: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i, data: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        for i in 0..<dataPoints.count {
            let dataEntry2 = ChartDataEntry(value: values2[i], xIndex: i, data: dataPoints[i])
            dataEntries2.append(dataEntry2)
        }
        
        let radarChartDataSet = RadarChartDataSet(yVals: dataEntries, label: "Low Risk")
        radarChartDataSet.drawFilledEnabled = true
        radarChartDataSet.colors = [low]
        radarChartDataSet.fillColor = low
        radarChartDataSet.drawFilledEnabled = true
        radarChartDataSet.drawValuesEnabled = false
        
        let radarChartDataSet2 = RadarChartDataSet(yVals: dataEntries2, label: "High Risk")
        radarChartDataSet2.drawFilledEnabled = true
        radarChartDataSet2.colors = [high]
        radarChartDataSet2.fillColor = high
        radarChartDataSet2.drawValuesEnabled = false
        
        let dataSets: [RadarChartDataSet] = [radarChartDataSet, radarChartDataSet2]
        let radarChartData = RadarChartData(xVals: dataPoints, dataSets: dataSets)
        let numberFormatter = NSNumberFormatter()
        
        numberFormatter.generatesDecimalNumbers = false
        radarChartData.setValueFormatter(numberFormatter)
        radarChartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        
        radarChartView.rotationEnabled = false
        radarChartView.descriptionText = ""
        radarChartView.innerWebColor = charcoal
        radarChartView.xAxis.labelPosition = .Bottom
        radarChartView.noDataTextDescription = "Data has not been selected"
        radarChartView.yAxis.enabled = false
        radarChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseOutSine)
        radarChartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        
        radarChartView.data = radarChartData
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        isGraphSelected = true
        //isShifting = true
        filteredTickets.removeAll()
        filteredEmergencyTickets.removeAll()
        liveTicketsShown.removeAll()
        
        if (entry.data != nil) {
            if (dataSetIndex == 0) {
                for ticket in liveTickets {
                    if (ticket.risk == "Low") {
                        filteredTickets += [ticket]
                    }
                }
                let ticketShown = [Bool](count: filteredTickets.count, repeatedValue: false)
                liveTicketsShown = ticketShown
                tableView.reloadData()
            } else if (dataSetIndex == 1) {
                for ticket in liveTickets {
                    if (ticket.risk == "High") {
                        filteredTickets += [ticket]
                    }
                }
                let ticketShown = [Bool](count: filteredTickets.count, repeatedValue: false)
                liveTicketsShown = ticketShown
                tableView.reloadData()
            }
        }
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        isGraphSelected = false
        liveTicketsShown.removeAll()
        let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        tableView.reloadData()
        
    }
}