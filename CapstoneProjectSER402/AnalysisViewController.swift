//
//  AnalysisViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/21/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//
import UIKit
import Charts

class AnalysisViewController: UIViewController, UITextFieldDelegate, ChartViewDelegate {
    
    private var wTickets = TicketModel()
    private var tbvc = TicketTabBarController()
    
    var ticketRisks = [Double]()
    var ticketStartDates = [String]()
    var selectedTF = UITextField()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    
    @IBOutlet weak var initialDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var selectedTicketCount: UILabel!
    @IBOutlet weak var horizontalBarChartView: HorizontalBarChartView!
    @IBOutlet weak var graphRepresentationControl: UISegmentedControl!
    @IBOutlet weak var releaseWindowSwitch: UISwitch!
    @IBOutlet weak var releaseWindowLabel: UILabel!
    
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
    
    @IBAction func repIndexChanged(sender: AnyObject) {
        switch graphRepresentationControl.selectedSegmentIndex
        {
        case 0:
            releaseWindowLabel.hidden = true
            releaseWindowSwitch.hidden = true
            releaseWindowSwitch.setOn(false, animated: true)
            let historicalDates = ["Jan '14", "Feb '14", "Mar '14", "Apr '14", "May '14"]
            let historicalTickets = [3.0, 4.0, 8.0, 6.0, 10.0]
            horizontalBarChartView.clear()
            setChart(historicalDates, values: historicalTickets)
            horizontalBarChartView.xAxis.removeLimitLine(releaseWindowLL)
        case 1:
            releaseWindowLabel.hidden = false
            releaseWindowSwitch.hidden = false
            let forwardDates = ["April '16", "May '16", "June '16", "Jul '16", "Aug '16"]
            let forwardTickets = [1.0, 1.0, 2.0, 1.0, 4.0]
            horizontalBarChartView.clear()
            setChart(forwardDates, values: forwardTickets)
        default:
            break;
        }
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            horizontalBarChartView.xAxis.removeLimitLine(releaseWindowLL)
            releaseWindowLL.valueTextColor = UIColor(red: (255/255.0), green: 0, blue: 0, alpha: 0.3)
            releaseWindowLL.lineColor = UIColor(red: (255/255.0), green: 0, blue: 0, alpha: 0.3)
            releaseWindowLL.lineWidth = CGFloat(horizontalBarChartView.xAxis.spaceBetweenLabels)
            releaseWindowLL.valueFont = UIFont(name: "Helvetica", size: 10)!
            releaseWindowLL.labelPosition = .RightBottom
            horizontalBarChartView.xAxis.addLimitLine(releaseWindowLL)
            horizontalBarChartView.setNeedsDisplay()
        } else {
            horizontalBarChartView.xAxis.removeLimitLine(releaseWindowLL)
            horizontalBarChartView.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horizontalBarChartView.delegate = self
        initialDate.delegate = self
        endDate.delegate = self
        releaseWindowSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: .ValueChanged)
        
        // Do any additional setup after loading the view.
        
        tbvc = tabBarController as! TicketTabBarController
        wTickets = tbvc.wTickets
        if (wTickets.watchedTickets.count > 0) {
            for i in 0..<wTickets.watchedTickets.count {
                ticketRisks.append(Double(wTickets.watchedTickets[i].priority))
                ticketStartDates.append(wTickets.watchedTickets[i].startDate)
            }
            setChart(ticketStartDates, values: ticketRisks)
        } else {
            repIndexChanged(0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (ticketRisks.count != wTickets.watchedTickets.count) {
            ticketRisks.removeAll()
            ticketStartDates.removeAll()
            for i in 0..<wTickets.watchedTickets.count {
                ticketRisks.append(Double(wTickets.watchedTickets[i].priority))
                ticketStartDates.append(wTickets.watchedTickets[i].startDate)
            }
            horizontalBarChartView.clear()
            setChart(ticketStartDates, values: ticketRisks)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        horizontalBarChartView.clear()
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Change Tickets Entered")
        let numberFormatter = NSNumberFormatter()
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        
        
        numberFormatter.generatesDecimalNumbers = false
        chartDataSet.valueFormatter = numberFormatter
        
        horizontalBarChartView.xAxis.labelPosition = .Bottom
        horizontalBarChartView.noDataTextDescription = "Data has not been selected"
        
        chartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        
        var colors: [UIColor] = []
        for _ in 0..<dataPoints.count {
            let randBlue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(randBlue/255), alpha: 1)
            colors.append(color)
        }
        chartDataSet.colors = ChartColorTemplates.liberty()
        horizontalBarChartView.leftAxis.enabled = false
        horizontalBarChartView.descriptionText = ""
        horizontalBarChartView.rightAxis.drawGridLinesEnabled = false
        horizontalBarChartView.xAxis.drawGridLinesEnabled = false
        horizontalBarChartView.rightAxis.valueFormatter = numberFormatter
        horizontalBarChartView.data = chartData
        horizontalBarChartView.backgroundColor = UIColor(red: CGFloat(228/255.0), green: CGFloat(241/255.0), blue: CGFloat(254/255.0), alpha: 1)
        horizontalBarChartView.drawBordersEnabled = false
        horizontalBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        selectedTicketCount.text = String(entry.value)
    }
    
}
