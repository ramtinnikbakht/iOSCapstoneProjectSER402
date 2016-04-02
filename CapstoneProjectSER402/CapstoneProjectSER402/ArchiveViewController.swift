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

class ArchiveViewController: UIViewController, UITextFieldDelegate, ChartViewDelegate {
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    private var wTickets = TicketModel()
    private var tbvc = TicketTabBarController()
    
    
    var closureCodes = [String]()
    var ticketRisks = [Double]()
    var ticketStartDates = [String]()
    var selectedTF = UITextField()
    var releaseWindowLL = ChartLimitLine(limit: 1.0, label: "Release \nDeployment \nWindow")
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closureCodes += ["Implemented as Planned", "Implemented with Effort", "Backed Out No Customer/User Impacts", "Implemented with Issues", "Backed Out Customer/User Impacts", "Failed to report status"]
        let values : [Double] = [30.0, 3.0, 3.0, 5.0, 4.0, 15.0]
        pieChartView.delegate = self

        // Do any additional setup after loading the view.
        
        setChart(closureCodes, values: values)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
