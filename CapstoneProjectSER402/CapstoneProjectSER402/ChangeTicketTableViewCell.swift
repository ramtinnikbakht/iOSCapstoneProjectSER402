//
//  ChangeTicketTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import QuartzCore


class ChangeTicketTableViewCell: UITableViewCell
{
    
    // MARK: Properties
    var isObserving = false
    
    @IBOutlet weak var ticketID: UILabel!
    @IBOutlet weak var businessUnitLabel: UILabel!
    @IBOutlet weak var plannedStartLabel: UILabel!
    @IBOutlet weak var riskLevelLabel: UILabel!
    @IBOutlet weak var subBusinessUnitLabel: UILabel!
    
    @IBOutlet weak var businessUnit: UILabel!
    @IBOutlet weak var subBusinessUnit: UILabel!
    @IBOutlet weak var riskLevel: UILabel!
    @IBOutlet weak var plannedStart: UILabel!
    let DateFormat = NSDateFormatter()
    
    @IBOutlet weak var riskIndicator: UIImageView!
    @IBOutlet weak var expandIndicator: UIImageView!
    
    class var expandedHeight : CGFloat { get { return 170 } }
    class var defaultHeight : CGFloat { get { return 44 } }
    
    func checkHeight() {
        businessUnitLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        subBusinessUnitLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        riskLevelLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        plannedStartLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        
        businessUnit.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        subBusinessUnit.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        riskLevel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        plannedStart.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true
        }
        
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false
        }
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    var ticket: ChangeTicket!
    {
        didSet {
            DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            ticketID.text = ticket.number
            riskLevel.text = ticket.risk
            businessUnit.text = ticket.requestedByGroupBusinessUnit
            subBusinessUnit.text = ticket.requestedByGroupSubBusinessUnit
            plannedStart.text = ticket.plannedStart
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
