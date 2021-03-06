//
//  WatchedTicketTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import QuartzCore


class WatchedTicketTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var isObserving = false;
   
    @IBOutlet weak var watchedTicketID: UILabel!
    
    
    @IBOutlet weak var watchedBusinessGroupLabel: UILabel!
    @IBOutlet weak var watchedBusinessGroup: UILabel!
    @IBOutlet weak var watchedSubBusinessGroupLabel: UILabel!
    @IBOutlet weak var watchedSubBusinessGroup: UILabel!
    @IBOutlet weak var watchedTicketRiskLabel: UILabel!
    @IBOutlet weak var watchedTicketPlannedLabel: UILabel!
    @IBOutlet weak var watchedPlannedDate: UILabel!
    @IBOutlet weak var watchedTicketPriority: UILabel!
    
    class var expandedHeight : CGFloat { get { return 170 } }
    class var defaultHeight : CGFloat { get { return 44 } }
    
    func checkHeight() {
        watchedBusinessGroupLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        watchedSubBusinessGroupLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        watchedTicketRiskLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        watchedTicketPlannedLabel.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        
        watchedTicketPriority.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        watchedBusinessGroup.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        watchedSubBusinessGroup.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        watchedPlannedDate.hidden = frame.size.height < WatchedTicketTableViewCell.expandedHeight
        
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
    
    var ticket: WatchedTicket! {
        didSet {
            watchedTicketID.text = ticket.id
            watchedTicketPriority.text = String(ticket.priority)
            watchedBusinessGroup.text = ticket.requestedByGroupBusinessUnit
            watchedSubBusinessGroup.text = ticket.requestedByGroupSubBusinessUnit
            watchedPlannedDate.text = ticket.startDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
