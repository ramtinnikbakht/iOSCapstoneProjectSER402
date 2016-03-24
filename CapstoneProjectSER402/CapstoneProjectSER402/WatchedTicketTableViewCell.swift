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
   
    @IBOutlet weak var watchedTicketLabel: UILabel!
    @IBOutlet weak var watchedPriorityLabel: UILabel!
    
    var ticket: WatchedTicket! {
        didSet {
            watchedTicketLabel.text = ticket.id
            watchedPriorityLabel.text = String(ticket.priority)
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
