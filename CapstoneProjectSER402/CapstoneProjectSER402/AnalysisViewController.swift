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
    @IBOutlet weak var initialDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var analysisView: UIView!
    @IBOutlet weak var selectedTicketCount: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    var months: [String]!
    
    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        textField.inputView = datePickerView
    }
    
    @IBAction func dateField(sender: UITextField) {
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: "handleDatePicker:", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .MediumStyle
        print(sender.date)
        initialDate.text = timeFormatter.stringFromDate(sender.date)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        initialDate.delegate = self
//        endDate.delegate = self
        // Do any additional setup after loading the view.
        
        tbvc = tabBarController as! TicketTabBarController
        wTickets = tbvc.wTickets
        for i in 0..<wTickets.watchedTickets.count {
            ticketRisks.append(Double(wTickets.watchedTickets[i].priority)!)
            ticketStartDates.append(wTickets.watchedTickets[i].startDate)
        }
        setChart(ticketStartDates, values: ticketRisks)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (ticketRisks.count != wTickets.watchedTickets.count) {
            print(ticketRisks.count)
            print(wTickets.watchedTickets.count)
            ticketRisks.removeAll()
            ticketStartDates.removeAll()
            for i in 0..<wTickets.watchedTickets.count {
                ticketRisks.append(Double(wTickets.watchedTickets[i].priority)!)
                ticketStartDates.append(wTickets.watchedTickets[i].startDate)
            }
            lineChartView.clear()
            setChart(ticketStartDates, values: ticketRisks)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Change Tickets Entered")
        let ll = ChartLimitLine(limit: 1.0, label: "Release Deployment Window")
        let chartData = LineChartData(xVals: dataPoints, dataSet: chartDataSet)
        lineChartView.xAxis.addLimitLine(ll)
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        selectedTicketCount.text = String(entry.value)
    }
    
}
