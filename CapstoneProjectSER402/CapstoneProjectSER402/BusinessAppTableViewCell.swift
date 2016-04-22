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
    @IBOutlet weak var businessAppLabel: UILabel!
    @IBOutlet weak var ticketTypeLabel: UILabel!
    
    var ticket: ChangeTicket!
        {
        didSet {
            ticketID.text = ticket.number
            plannedStartLabel.text = convertDate(ticket.plannedStart)
            if (ticket.BusinessApplication == "element <business_Application> not found") {
                businessAppLabel.text = ticket.requestedByGroup
            } else {
               businessAppLabel.text = ticket.BusinessApplication
            }
            ticketTypeLabel.text = ticket.type
        }
    }
    
    func convertDate(var longDate: String) -> String {
        var dateArr = longDate.characters.split{$0 == " "}.map(String.init)
        let time = dateArr[1]
        var components = time.characters.split{$0 == ":"}.map(String.init)
        let hour = components[0]
        if (Int(hour) > 12) {
            let convertedHour = Int(hour)! - 12
            longDate = String(convertedHour) + ":" + components[1] + ":" + components[2] + " PM"
        } else {
            longDate = components[0] + ":" + components[1] + ":" + components[2] + " AM"
        }
        return longDate
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
