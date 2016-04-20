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
    let DateFormat = NSDateFormatter()
    
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attributeValue: UILabel!
    
    
    var ticket: ChangeTicket!
    {
        didSet {
            DateFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            DateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
