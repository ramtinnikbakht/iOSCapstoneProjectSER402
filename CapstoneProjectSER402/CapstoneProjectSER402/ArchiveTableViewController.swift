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
    @IBOutlet weak var timeSegmentControl: UISegmentedControl!
    //@IBOutlet weak var legendDisplay: UIImageView!
    
    private var tickets = TicketModel()
    private var tbvc = TicketTabBarController()
    
    let closureCodes : [String] = ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
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
    var cc1Tickets = Array<[ChangeTicket]>()
    var cc2Tickets = Array<[ChangeTicket]>()
    var cc3Tickets = Array<[ChangeTicket]>()
    var cc4Tickets = Array<[ChangeTicket]>()
    var cc5Tickets = Array<[ChangeTicket]>()
    var cc6Tickets = Array<[ChangeTicket]>()
    
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
        switch timeSegmentControl.selectedSegmentIndex
        {
        case 0:
            pieChartView.resignFirstResponder()
            tableView.resignFirstResponder()
            liveTickets.removeAll()
            ConnectionService.sharedInstance.getChange(actualEnd: "2016-03-10 00:00:00", actualEnd2: "2016-03-10 24:00:00", aeD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortClosureCodes()
            setValuesForGraph()
            tableView.reloadData()
        case 1:
            pieChartView.resignFirstResponder()
            tableView.resignFirstResponder()
            liveTickets.removeAll()
            ConnectionService.sharedInstance.getChange(actualEnd: "2016-03-07 00:00:00", actualEnd2: "2016-03-07 24:00:00", aeD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortClosureCodes()
            setValuesForGraph()
            tableView.reloadData()
        case 2:
            pieChartView.resignFirstResponder()
            tableView.resignFirstResponder()
            liveTickets.removeAll()
            ConnectionService.sharedInstance.getChange(actualEnd: "2016-03-08 00:00:00", actualEnd2: "2016-03-08 24:00:00", aeD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            sortClosureCodes()
            setValuesForGraph()
            tableView.reloadData()
        default:
            break;
        }
    }
    
    func displayLegendDetails() {
        let aRectangle = CGRectMake(246, 28, 130, 30)
        let largerRect = CGRectInset(aRectangle, -30, 0)
    }
    
    func loadTickets() {
        DateFormat.locale = NSLocale(localeIdentifier: "US_en")
        DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = NSDate()
        //let time1 = DateFormat.stringFromDate(now)
        //let time2 = DateFormat.stringFromDate(now.minusDays(2))
        
        ConnectionService.sharedInstance.getChange(actualEnd: "2016-03-10 00:00:00", actualEnd2: "2016-03-10 24:00:00", aeD: "1")
        liveTickets = ConnectionService.sharedInstance.ticketList
        
        sortClosureCodes()
    }
    
    func sortClosureCodes() {
        cc1Tickets.removeAll()
        cc2Tickets.removeAll()
        cc3Tickets.removeAll()
        cc4Tickets.removeAll()
        cc5Tickets.removeAll()
        cc6Tickets.removeAll()
        activeCodes.removeAll()
        for ticket in liveTickets {
            if (ticket.closureCode == "Implemented as Planned") {
                cc1Tickets.append(Array(arrayLiteral: ticket))
                
            } else if (ticket.closureCode == "Implemented with Effort") {
                cc2Tickets.append(Array(arrayLiteral: ticket))
                
            } else if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
                cc3Tickets.append(Array(arrayLiteral: ticket))
                
            } else if (ticket.closureCode == "Implemented with Issues") {
                cc4Tickets.append(Array(arrayLiteral: ticket))
                
            } else if (ticket.closureCode == "Backed Out Customer/User Impacts") {
                cc5Tickets.append(Array(arrayLiteral: ticket))
                
            } else if (ticket.closureCode == "") {
                cc6Tickets.append(Array(arrayLiteral: ticket))
            }
            
            if (activeCodes.contains(ticket.closureCode)) {
                
            } else {
                activeCodes += [ticket.closureCode]
            }
        }
    }
    
    func setValuesForGraph() {
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
            } else {
                values += [Double(cc6Tickets.count)]
            }
        }
        setChart(activeCodes, values: values)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pieChartView.delegate = self
        loadTickets()
        sortClosureCodes()
        setValuesForGraph()
        
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
            return liveTickets.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ArchiveTableViewCell
        let white = UIColor.whiteColor()
        var ticket : ChangeTicket
        
        if (isGraphSelected) {
            ticket = filteredTickets[indexPath.row] as ChangeTicket
        } else {
            ticket = liveTickets[indexPath.row] as ChangeTicket
        }
       
        // Cell Color - Based on Closure Code
        if (ticket.closureCode == "Implemented as Planned") {
            cell.ccIndicator.backgroundColor = cc1
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Implemented with Effort") {
            cell.ccIndicator.backgroundColor = cc2
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
            cell.ccIndicator.backgroundColor = cc3
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Implemented with Issues") {
            cell.ccIndicator.backgroundColor = cc4
            cell.backgroundColor = white
        } else if (ticket.closureCode == "Backed Out Customer/User Impacts") {
            cell.ccIndicator.backgroundColor = cc5
            cell.backgroundColor = white
        } else if (ticket.closureCode == "") {
            cell.ccIndicator.backgroundColor = cc6
            cell.backgroundColor = white
            cell.ticketID.textColor = UIColor.blackColor()
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
    var animateIndex = 0
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if (isShifting) {
            
        } else {
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
            } else if (dataPoints[i] == ""){
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
        isShifting = true
        filteredTickets.removeAll()
        
        if (entry.data! as! String == closureCodes[0]) {
            let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = .Center
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[0], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)!])
            for ticket in liveTickets {
                if (ticket.closureCode == "Implemented as Planned") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[1]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[1], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in liveTickets {
                if (ticket.closureCode == "Implemented with Effort") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[2]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[2], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in liveTickets {
                if (ticket.closureCode == "Backed Out No Customer/User Impacts") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[3]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[3], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in liveTickets {
                if (ticket.closureCode == "Implemented with Issues") {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.data! as! String == closureCodes[4]) {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[4], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in liveTickets {
                if (ticket.closureCode == "Backed Out Customer/User Impacts") {
                    filteredTickets += [ticket]
                }
            }
        }
        else {
            pieChartView.centerAttributedText = NSAttributedString(string: closureCodes[5], attributes: [
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSFontAttributeName: NSUIFont(name: "Helvetica", size: 10)! ])
            for ticket in liveTickets {
                if (ticket.closureCode == "") {
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
