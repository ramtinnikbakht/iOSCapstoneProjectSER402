
//
//  ChangeTicketTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import Charts

class ChangeTicketTableViewController: UITableViewController, ChartViewDelegate {
    
    // MARK: Properties
    @IBOutlet weak var selectedAppLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    private var tbvc = TicketTabBarController()
    private var tickets = TicketModel()
    var changeTickets = [ChangeTicket_Table_Template]()
    var filteredTickets = [ChangeTicket_Table_Template]()
    var selectedApp = String()
    var selectedIndexPath : NSIndexPath?
    var isGraphSelected = false
    let cellIdentifier = "TicketCell"
    let low = UIColor(red: CGFloat(38/255.0), green: CGFloat(166/255.0), blue: CGFloat(91/255.0), alpha: 1)
    let med = UIColor(red: CGFloat(244/255.0), green: CGFloat(208/255.0), blue: CGFloat(63/255.0), alpha: 1)
    let high = UIColor(red: CGFloat(207/255.0), green: CGFloat(0), blue: CGFloat(15/255.0), alpha: 1)
    let riskLevels = ["Low", "Med", "High"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChartView.delegate = self
        selectedAppLabel.text = selectedApp
        loadSampleTickets()
        
        let unitsSold = [2.0, 3.0, 1.0]
        
        setChart(riskLevels, values: unitsSold)
    }
    
    
    func loadSampleTickets() {
        let eyeIcon = UIImage(named: "eye_unclicked.png")
        let obj1 = ChangeTicket(number: "CHG00313717", approver: "", plannedStart: "2016-02-11 03:30:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "4", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj2 = ChangeTicket(number: "CHG00314757", approver: "", plannedStart: "2016-04-25 15:05:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "8", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        let obj3 = ChangeTicket(number: "CHG00318797", approver: "", plannedStart: "2016-06-18 06:15:00", plannedEnd: "2016-02-11 08:00:00", actualStart: "", actualEnd: "", requestedByGroup: "ServiceNow_DEV", requestedByGroupBusinessArea: "Infrastructure Services", requestedByGroupBusinessUnit: "IS – Infrastructure Services", requestedByGroupSubBusinessUnit: "IS - Production Process", causeCompleteServiceAppOutage: "No", risk: "2", type: "Normal", impactScore: "", shortDescription: "Servicenow 02/10 Release", changeReason: "New Capability", closureCode: "", ImpactedEnviroment: "Production", SecondaryClosureCode: "", PartofRelease: "", BusinessApplication: "ServiceNow Enterprise Edition", BusinessApplicationCriticalityTier: "Tier 2")
        
        let ticket1 = ChangeTicket_Table_Template(id: obj1.getNumber(), priority: obj1.getRisk(), startDate: obj1.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj1.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj1.getRequestedByGroupSubBusinessUnit())
        let ticket2 = ChangeTicket_Table_Template(id: obj2.getNumber(), priority: obj2.getRisk(),startDate: obj2.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj2.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj2.getRequestedByGroupSubBusinessUnit())
        let ticket3 = ChangeTicket_Table_Template(id: obj3.getNumber(), priority: obj3.getRisk(),startDate: obj3.getPlannedStart(), icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: obj3.getRequestedByGroupBusinessUnit(), requestedByGroupSubBusinessUnit: obj3.getRequestedByGroupSubBusinessUnit())
        let ticket4 = ChangeTicket_Table_Template(id: "CHG00314219", priority: "5",startDate: "2016-011-5 18:15:00", icon: eyeIcon!, isWatched: false, requestedByGroupBusinessUnit: "IS - Infrastructure", requestedByGroupSubBusinessUnit: "IS - Production Process")
        
        
        changeTickets += [ticket1, ticket2, ticket3, ticket4]
        tickets.addChangeTickets(ticket1)
        tickets.addChangeTickets(ticket2)
        tickets.addChangeTickets(ticket3)
        tickets.addChangeTickets(ticket4)
        var medIndex = 0
        for ticket in changeTickets {
            if (Int(ticket.priority) > 3 && Int(ticket.priority) <= 7) {
                changeTickets.removeAtIndex(medIndex)
                changeTickets.insert(ticket, atIndex: 0)
            }
            medIndex++
        }
        var highIndex = 0
        for ticket in changeTickets {
            if (Int(ticket.priority) > 7) {
                changeTickets.removeAtIndex(highIndex)
                changeTickets.insert(ticket, atIndex: 0)
            }
            highIndex++
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isGraphSelected) {
            return filteredTickets.count
        } else {
            return changeTickets.count
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChangeTicketTableViewCell
        var ticket : ChangeTicket_Table_Template
        if (isGraphSelected) {
            ticket = filteredTickets[indexPath.row] as ChangeTicket_Table_Template
        } else {
            ticket = changeTickets[indexPath.row] as ChangeTicket_Table_Template
        }
        if (Int(ticket.priority) <= 3) {
            cell.backgroundColor = low
            let white = UIColor.whiteColor()
            cell.plannedStartLabel.textColor = white
            cell.businessUnitLabel.textColor = white
            cell.subBusinessUnitLabel.textColor = white
            cell.riskLevelLabel.textColor = white
            cell.ticketID.textColor = white
            cell.businessUnit.textColor = white
            cell.subBusinessUnit.textColor = white
            cell.plannedStart.textColor = white
            cell.riskLevel.textColor = white
        } else if (Int(ticket.priority) > 3 && Int(ticket.priority) <= 7) {
            cell.backgroundColor = med
            cell.plannedStartLabel.textColor = UIColor.blackColor()
            cell.businessUnitLabel.textColor = UIColor.blackColor()
            cell.subBusinessUnitLabel.textColor = UIColor.blackColor()
            cell.riskLevelLabel.textColor = UIColor.blackColor()
            cell.ticketID.textColor = UIColor.blackColor()
            cell.businessUnit.textColor = UIColor.blackColor()
            cell.subBusinessUnit.textColor = UIColor.blackColor()
            cell.plannedStart.textColor = UIColor.blackColor()
            cell.riskLevel.textColor = UIColor.blackColor()
        } else if (Int(ticket.priority) > 7) {
            cell.backgroundColor = high
            let white = UIColor.whiteColor()
            cell.plannedStartLabel.textColor = white
            cell.businessUnitLabel.textColor = white
            cell.subBusinessUnitLabel.textColor = white
            cell.riskLevelLabel.textColor = white
            cell.ticketID.textColor = white
            cell.businessUnit.textColor = white
            cell.subBusinessUnit.textColor = white
            cell.plannedStart.textColor = white
            cell.riskLevel.textColor = white
        }
        let white = UIColor.whiteColor()
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
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! ChangeTicketTableViewCell).watchFrameChanges()
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! ChangeTicketTableViewCell).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells as! [ChangeTicketTableViewCell] {
            cell.ignoreFrameChanges()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return ChangeTicketTableViewCell.expandedHeight
        } else {
            return ChangeTicketTableViewCell.defaultHeight
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        pieChartView.clear()
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Risk Level")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        let numberFormatter = NSNumberFormatter()
        pieChartView.data = pieChartData

        numberFormatter.generatesDecimalNumbers = false
        pieChartData.setValueFormatter(numberFormatter)
        
        pieChartData.setValueFont(UIFont(name: "Helvetica", size: 12))
        
        var colors: [UIColor] = []
    
        for i in 0..<dataPoints.count {
            if (dataPoints[i] == "Low") {
                let color = low
                colors.append(color)
            } else if (dataPoints[i] == "Med") {
                let color = med
                colors.append(color)
            } else if (dataPoints[i] == "High"){
                let color = high
                colors.append(color)
            }
            pieChartDataSet.colors = colors
        }
        
        // Legend Data
        pieChartView.legend.position = .PiechartCenter
        pieChartView.legend.font = UIFont(name: "Helvetica", size: 10)!
        pieChartView.legend.colors = [low, med, high]
        pieChartView.legend.labels = ["Low Risk","Medium Risk","High Risk"]
        pieChartView.legend.enabled = true
        
        pieChartView.descriptionText = ""
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .EaseOutSine)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        isGraphSelected = true
        filteredTickets.removeAll()
        print(entry.value)
        if (entry.value == 2.0) {
            for ticket in changeTickets {
                if (Int(ticket.priority) <= 3) {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.value == 3.0) {
            for ticket in changeTickets {
                if (Int(ticket.priority) > 3 && Int(ticket.priority) <= 7) {
                    filteredTickets += [ticket]
                }
            }
        }
        else if(entry.value == 1.0) {
            for ticket in changeTickets {
                if (Int(ticket.priority) > 7) {
                    filteredTickets += [ticket]
                }
            }
        }
        tableView.reloadData()

    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        isGraphSelected = false
        tableView.reloadData()
    }
}