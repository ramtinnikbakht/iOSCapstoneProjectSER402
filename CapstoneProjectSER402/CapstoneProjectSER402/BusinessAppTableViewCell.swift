//
//  ChangeTicketTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import QuartzCore


class BusinessAppTableViewCell: UITableViewCell
{
    
    // MARK: Properties
    
    @IBOutlet weak var ticketID: UILabel!
    @IBOutlet weak var plannedStartLabel: UILabel!
    @IBOutlet weak var riskIndicator: UIImageView!
    @IBOutlet weak var emergencyIndicator: UIImageView!
    
    var ticket: ChangeTicket!
        {
        didSet {
            ticketID.text = ticket.number
            plannedStartLabel.text = ticket.plannedStart
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
