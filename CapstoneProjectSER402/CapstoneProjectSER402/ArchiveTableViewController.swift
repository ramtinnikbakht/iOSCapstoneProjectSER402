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
import CoreData

class ArchiveTableViewController: UITableViewController, UITextFieldDelegate, ChartViewDelegate {
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var timeSegmentControl: UISegmentedControl!
    @IBOutlet weak var noTicketsAvailableImage: UIImageView!
    
    private var tickets = TicketModel()
    private var tbvc = TicketTabBarController()
    
    let closureCodes : [String] = ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
    var userType = ""
    var activeCodes : [String] = []
    var ticketStartDates = [String]()
    var selectedTF = UITextField()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    var liveTickets = [ChangeTicket]()
    var fullTickets = [ChangeTicket]()
    var changeTickets = [ChangeTicket]()
    var filteredTickets = [ChangeTicket]()
    var selectedApp = String()
    var selectedIndexPath : NSIndexPath?
    var isShifting = false
    var isGraphSelected = false
    var cc1Tickets = [ChangeTicket]()
    var cc2Tickets = [ChangeTicket]()
    var cc3Tickets = [ChangeTicket]()
    var cc4Tickets = [ChangeTicket]()
    var cc5Tickets = [ChangeTicket]()
    var cc6Tickets = [ChangeTicket]()
    var mockData = MockData()
    var liveTicketsShown : [Bool] = []
    var shouldAnimate = true
    var appDel:AppDelegate?
    var context:NSManagedObjectContext?
    
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
    let charcoal = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
    
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
    
    @IBAction func timeIndexChanged(sender: AnyObject) {
        
        liveTickets.removeAll()
        isGraphSelected = false
        
        loadTickets(timeSegmentControl.selectedSegmentIndex)
        
        setValuesForGraph()
        tableView.reloadData()
    }
    
    func loadTickets(segmentIndex: Int) {
        DateFormat.locale = NSLocale(localeIdentifier: "US_en")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = NSDate()
        let dayMax = now.minusDays(1)
        let threeDayMax = now.minusDays(3)
        let weekMax = now.minusDays(7)
        var time1 = ""
        var time2 = ""
        
        if (userType == "Demo") {
            liveTickets = mockData.MOCK_DATA_ARRAY
            liveTickets = filterTicketTimes(segmentIndex)
            let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
            liveTicketsShown = ticketShown
            sortClosureCodes(liveTickets)
        } else {
            if (segmentIndex == 0) {
                time1 = DateFormat.stringFromDate(dayMax)
                time2 = DateFormat.stringFromDate(now)
                
            } else if (segmentIndex == 1) {
                time1 = DateFormat.stringFromDate(threeDayMax)
                time2 = DateFormat.stringFromDate(now)
            } else {
                time1 = DateFormat.stringFromDate(weekMax)
                time2 = DateFormat.stringFromDate(now)
            }
            ConnectionService.sharedInstance.getChange(actualEnd: time1, actualEnd2: time2, aeD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
            liveTicketsShown = ticketShown
            sortClosureCodes(liveTickets)
        }
    }
    
    func sortClosureCodes(tickets: [ChangeTicket]) {
        cc1Tickets.removeAll()
        cc2Tickets.removeAll()
        cc3Tickets.removeAll()
        cc4Tickets.removeAll()
        cc5Tickets.removeAll()
        cc6Tickets.removeAll()
        activeCodes.removeAll()
        for ticket in tickets {
            if (ticket.closureCode == "Implemented as Planned") {
                cc1Tickets += [ticket]
                
            } else if (ticket.closureCode == "Implemented with Effort") {
                cc2Tickets += [ticket]
                
            } else if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
                cc3Tickets += [ticket]
                
            } else if (ticket.closureCode == "Implemented with Issues") {
                cc4Tickets += [ticket]
                
            } else if (ticket.closureCode == "Backed Out Customer/User Impacts") {
                cc5Tickets += [ticket]
                
            } else {
                cc6Tickets += [ticket]
            }
            
            if (activeCodes.contains(ticket.closureCode)) {
                
            } else {
                activeCodes += [ticket.closureCode]
            }
        }
    }
    
    func setValuesForGraph() {
        var values : [Double] = []
        var zeroCounter : Int = 0
        
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
            } else {
                values += [Double(cc6Tickets.count)]
            }
        }
        
        for value in values {
            if (value == 0) {
                zeroCounter++
            }
        }
        
        if (zeroCounter == values.count) {
            noTicketsAvailableImage.hidden = false
            noTicketsAvailableImage.image = UIImage(named: "EmptyGraphIcon.png")
            setChart(activeCodes, values: values)
        } else {
            noTicketsAvailableImage.hidden = true
            setChart(activeCodes, values: values)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pieChartView.delegate = self
        appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel!.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        do
        {
            let results:NSArray = try context!.executeFetchRequest(fetchRequest)
            let max = results.count - 1
            userType = results[max].userType!
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        if (userType == "Demo") {
            liveTickets = mockData.parseExampleXMLFile()
            liveTickets = filterTicketTimes(0)
        } else {
            loadTickets(0)
        }
        
        let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        
        sortClosureCodes(liveTickets)
        setValuesForGraph()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return closureCodes.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0: return cc1Tickets.count
        case 1: return cc2Tickets.count
        case 2: return cc3Tickets.count
        case 3: return cc4Tickets.count
        case 4: return cc5Tickets.count
        case 5: return cc6Tickets.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ArchiveTableViewCell
        let white = UIColor.whiteColor()
        var ticket : ChangeTicket
    
        switch (indexPath.section) {
        case 0:
            ticket = cc1Tickets[indexPath.row] as ChangeTicket
            cell.ccIndicator.backgroundColor = cc1
        case 1:
            ticket = cc2Tickets[indexPath.row] as ChangeTicket
            cell.ccIndicator.backgroundColor = cc2
        case 2:
            ticket = cc3Tickets[indexPath.row] as ChangeTicket
            cell.ccIndicator.backgroundColor = cc3
        case 3:
            ticket = cc4Tickets[indexPath.row] as ChangeTicket
            cell.ccIndicator.backgroundColor = cc4
        case 4:
            ticket = cc5Tickets[indexPath.row] as ChangeTicket
            cell.ccIndicator.backgroundColor = cc5
        case 5:
            ticket = cc6Tickets[indexPath.row] as ChangeTicket
            cell.ccIndicator.backgroundColor = cc6
            cell.ticketID.textColor = UIColor.blackColor()
        default:
            ticket = liveTickets[indexPath.row] as ChangeTicket
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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("ArchiveHeaderCell") as! CustomHeaderCell
        let white = UIColor.whiteColor()
        
        headerCell.backgroundColor = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
        headerCell.appTierLabel.text = closureCodes[section]
        headerCell.appTierLabel.textColor = white
        
        headerCell.layer.shadowColor = white.CGColor
        headerCell.layer.shadowRadius = 1.5
        headerCell.layer.shadowOpacity = 0.7
        headerCell.layer.shadowOffset = CGSizeZero
        headerCell.layer.masksToBounds = false
        
        return headerCell
    }
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (liveTicketsShown[indexPath.row] == false) {
            let cellPosition = indexPath.indexAtPosition(1)
            var delay : Double = Double(cellPosition) * 0.1
            if (delay >= 0.6) {
                delay = 0.0
            }
            
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -1000, 0, 0)
            
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                cell.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
            liveTicketsShown[indexPath.row] = true
        }
    }
    
    func filterTicketTimes(segmentIndex: Int) -> [ChangeTicket] {
        DateFormat.locale = NSLocale(localeIdentifier: "US_en")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var filteredByTime : [ChangeTicket] = []
        let now = NSDate()
        let currentDay = now.day
        let currentMonth = now.month
        let threeDayMax = now.minusDays(3).day
        let weekMax = now.minusDays(7).day
        
        for ticket in liveTickets {
            if (ticket.actualEnd != "") {
                let ticketActualEnd = DateFormat.dateFromString(ticket.actualEnd)
                let ticketDay = ticketActualEnd?.day
                let ticketMonth = ticketActualEnd!.month
                
                if (segmentIndex == 0) {
                    if (ticketDay == currentDay) {
                        filteredByTime += [ticket]
                    }
                } else if (segmentIndex == 1) {
                    if (ticketDay >= threeDayMax || ticketMonth > currentMonth) {
                        filteredByTime += [ticket]
                    }
                } else if (segmentIndex == 2) {
                    if (ticketDay >= weekMax || ticketMonth > currentMonth) {
                        filteredByTime += [ticket]
                    }
                }
            }
        }
        return filteredByTime
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
            } else {
                let color = cc6
                colors.append(color)
            }
            pieChartDataSet.colors = colors
        }
        
        // Legend Data
        pieChartView.legend.enabled = false
        pieChartView.legend.yOffset = 40
        pieChartView.legend.xOffset = 25
        pieChartView.legend.position = .RightOfChart
        pieChartView.legend.form = .Circle
        pieChartView.legend.font = UIFont(name: "Helvetica", size: 9)!
        pieChartView.legend.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pieChartView.legend.colors = [cc1, cc2, cc3, cc4, cc5, cc6]

        pieChartView.legend.labels = ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
        
        pieChartView.drawCenterTextEnabled = true
        pieChartView.centerAttributedText = NSAttributedString(string: "", attributes: [
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSFontAttributeName: NSUIFont(name: "Helvetica", size: 11)! ])
        pieChartView.drawSliceTextEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.descriptionText = ""
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseOutSine)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        isGraphSelected = true
        isShifting = true
        filteredTickets.removeAll()
        liveTicketsShown.removeAll()
        sortClosureCodes(liveTickets)
        
        if (entry.data! as! String == closureCodes[0]) {
            let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = .Center
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[0], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)!])
            filteredTickets = cc1Tickets
            
        }
        else if(entry.data! as! String == closureCodes[1]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[1], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            filteredTickets = cc2Tickets
        }
        else if(entry.data! as! String == closureCodes[2]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[2], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            filteredTickets = cc3Tickets
        }
        else if(entry.data! as! String == closureCodes[3]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[3], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            filteredTickets = cc4Tickets
        }
        else if(entry.data! as! String == closureCodes[4]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[4], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            filteredTickets = cc5Tickets
        }
        else {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[5], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            filteredTickets = cc6Tickets
        }
        let ticketShown = [Bool](count: filteredTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        sortClosureCodes(filteredTickets)
        tableView.reloadData()
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        isGraphSelected = false
        pieChartView.centerText?.removeAll()
        liveTicketsShown.removeAll()
        sortClosureCodes(liveTickets)
        let ticketShown = [Bool](count: liveTickets.count, repeatedValue: false)
        liveTicketsShown = ticketShown
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showAppDetailArchive" {
            let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let detailVC:ChangeTicketTableViewController = segue.destinationViewController as! ChangeTicketTableViewController
            let ticket:ChangeTicket
            
            switch (indexPath.section) {
            case 0:
                ticket = cc1Tickets[indexPath.row] as ChangeTicket
            case 1:
                ticket = cc2Tickets[indexPath.row] as ChangeTicket
            case 2:
                ticket = cc3Tickets[indexPath.row] as ChangeTicket
            case 3:
                ticket = cc4Tickets[indexPath.row] as ChangeTicket
            case 4:
                ticket = cc5Tickets[indexPath.row] as ChangeTicket
            case 5:
                ticket = cc6Tickets[indexPath.row] as ChangeTicket
            default:
                ticket = liveTickets[indexPath.row] as ChangeTicket
            }
            detailVC.selectedTicket = ticket
        }
    }
    
}
