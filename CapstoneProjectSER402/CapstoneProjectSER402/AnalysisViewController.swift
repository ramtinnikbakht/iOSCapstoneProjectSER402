//
//  AnalysisViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/21/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//
import UIKit
import Charts

class AnalysisViewController: UIViewController {
    
    @IBOutlet var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"]
        let chgTicketsEntered = [10.0, 3.0, 5.0, 2.0, 6.0, 11.0, 4.0, 12.0, 2.0, 6.0, 9.0, 10.0]
        setChart(months, values: chgTicketsEntered)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Change Tickets Entered")
        chartDataSet.colors = ChartColorTemplates.liberty()
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
    }
}
