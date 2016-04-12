//
//  ArchiveTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 4/3/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {

    @IBOutlet weak var ticketID: UILabel!
    @IBOutlet weak var ccIndicator: UIImageView!
    @IBOutlet weak var actualEndLabel: UILabel!
    
    var ticket: ChangeTicket!
        {
        didSet {
            ticketID.text = ticket.number
            actualEndLabel.text = ticket.actualEnd
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
