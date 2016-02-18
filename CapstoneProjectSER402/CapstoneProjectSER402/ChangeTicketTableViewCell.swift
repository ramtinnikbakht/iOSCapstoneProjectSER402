//
//  ChangeTicketTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 2/17/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class ChangeTicketTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var ticketNumber: UILabel!
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var viewIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
