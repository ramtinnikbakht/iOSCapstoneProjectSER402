//
//  AnalysisViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/21/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//
import UIKit
import Charts
import Foundation

class AnalysisViewController: UIViewController, UITextFieldDelegate, ChartViewDelegate {
    
    var ticketRisks = [Double]()
    var ticketStartDates = [String]()
    var daySegments = [String]()
    var timeSegments = [String]()
    var lowRiskCount = [Double]()
    var highRiskCount = [Double]()
    var selectedHours = [UInt]()
    var selectedHourLabels = [String]()
    var selectedTF = UITextField()
    var liveTickets = [ChangeTicket]()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    var selectedDay = String()
    
    let DateFormat = NSDateFormatter()
    
    // Colors
    let low = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 0.4)
    let med = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 0.6)
    let high = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 0.6)
    let charcoal = UIColor(red: CGFloat(54/255.0), green: CGFloat(69/255.0), blue: CGFloat(79/255.0), alpha: 1)
    
    
    @IBOutlet weak var currentTimeFrameTF: UITextField!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var radarChartView: RadarChartView!

    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timeFrameStepper: UIStepper!
    @IBOutlet weak var highRiskCountLabel: UILabel!
    @IBOutlet weak var lowRiskCountLabel: UILabel!
    @IBOutlet weak var ticketTotalBackground: UIImageView!
    
    
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
        switch timeSegmentedControl.selectedSegmentIndex
        {
        case 0:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[0]
            calculateTimeFrame(daySegments[0], counterValue: 0)
            let currentDate = daySegments[0].characters.split{$0 == " "}.map(String.init)
            currentDateLabel.text = currentDate[0]
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
        case 1:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[1]
            calculateTimeFrame(daySegments[1], counterValue: 0)
            let currentDate = daySegments[1].characters.split{$0 == " "}.map(String.init)
            currentDateLabel.text = currentDate[0]
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            print(liveTickets)
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
        case 2:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[2]
            calculateTimeFrame(daySegments[2], counterValue: 0)
            let currentDate = daySegments[2].characters.split{$0 == " "}.map(String.init)
            currentDateLabel.text = currentDate[0]
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
        case 3:
            liveTickets.removeAll()
            calculateDaySegment()
            selectedDay = daySegments[3]
            calculateTimeFrame(daySegments[3], counterValue: 0)
            let currentDate = daySegments[3].characters.split{$0 == " "}.map(String.init)
            currentDateLabel.text = currentDate[0]
            ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
            liveTickets = ConnectionService.sharedInstance.ticketList
            calculateGraphValues()
            radarChartView.clear()
            timeFrameStepper.value = 0
            setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
        default:
            break;
        }
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        let timeFrameIndex = Int(sender.value)
        liveTickets.removeAll()
        calculateDaySegment()
        calculateTimeFrame(selectedDay, counterValue: timeFrameIndex)
        
        ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
        liveTickets = ConnectionService.sharedInstance.ticketList
        calculateGraphValues()
        radarChartView.clear()
        print(selectedHourLabels)
        print(lowRiskCount)
        print(highRiskCount)
        setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
    }
    
    func setupSegmentControl() {
        let firstDay = DateFormat.dateFromString(daySegments[1])
        let firstDayLabel = String(firstDay!.month) + "-" + String(firstDay!.day) + "-" + String(firstDay!.year)
        let secondDay = DateFormat.dateFromString(daySegments[2])
        let secondDayLabel = String(secondDay!.month) + "-" + String(secondDay!.day) + "-" + String(secondDay!.year)
        let thirdDay = DateFormat.dateFromString(daySegments[3])
        let thirdDayLabel = String(thirdDay!.month) + "-" + String(thirdDay!.day) + "-" + String(thirdDay!.year)
        
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
        
        currentTimeFrameTF.text = (String(time1) + ":00:00") + " - " + (String(time6) + ":00:00")
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
        lowRiskCountLabel.text = lowTicketTotal.description
        highRiskCountLabel.text = highTicketTotal.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radarChartView.delegate = self
        timeFrameStepper.wraps = true
        timeFrameStepper.autorepeat = false
        timeFrameStepper.maximumValue = 3
        ticketTotalBackground.backgroundColor = charcoal

        // Do any additional setup after loading the view.
        
        calculateDaySegment()
        selectedDay = daySegments[0]
        calculateTimeFrame(daySegments[0], counterValue: 0)
        let currentDate = daySegments[0].characters.split{$0 == " "}.map(String.init)
        currentDateLabel.text = currentDate[0]
        ConnectionService.sharedInstance.getChange(plannedStart: timeSegments[0], plannedStart2: timeSegments[5], psD: "1")
        liveTickets = ConnectionService.sharedInstance.ticketList
        calculateGraphValues()
        setupSegmentControl()
        setChart(selectedHourLabels, values: lowRiskCount, values2: highRiskCount)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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

    }
    
}
