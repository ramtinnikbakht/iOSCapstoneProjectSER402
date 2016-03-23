//
//  AnalysisViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/21/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//
import UIKit
import Charts

class AnalysisViewController: UIViewController, ChartViewDelegate {
    
    private var wTickets = TicketModel()
    private var tbvc = TicketTabBarController()
    var ticketRisks = [Double]()
    @IBOutlet weak var analysisView: UIView!
    @IBOutlet weak var selectedTicketCount: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
        // Do any additional setup after loading the view.
        
        tbvc = tabBarController as! TicketTabBarController
        wTickets = tbvc.wTickets
        for i in 0..<wTickets.watchedTickets.count {
            ticketRisks.append(Double(wTickets.watchedTickets[i].priority))
        }
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"]
        setChart(months, values: ticketRisks)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"]
        if (ticketRisks.count != wTickets.watchedTickets.count) {
            print(ticketRisks.count)
            print(wTickets.watchedTickets.count)
            ticketRisks.removeAll()
            for i in 0..<wTickets.watchedTickets.count {
                ticketRisks.append(Double(wTickets.watchedTickets[i].priority))
            }
            barChartView.clear()
            setChart(months, values: ticketRisks)
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Change Tickets Entered")
        chartDataSet.colors = ChartColorTemplates.liberty()
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        selectedTicketCount.text = String(entry.value)
    }
}
