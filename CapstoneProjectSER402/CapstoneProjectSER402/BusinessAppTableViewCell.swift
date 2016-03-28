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
    
    @IBOutlet weak var ticketCount: UILabel!
    @IBOutlet weak var businessAppName: UILabel!
    @IBOutlet weak var circle: UIImageView!
    
    var app: BusinessApp_Table_Template!
        {
        didSet
        {
            businessAppName.text = app.appName
            ticketCount.text = String(app.ticketCount)
            circle.image = app.icon
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
