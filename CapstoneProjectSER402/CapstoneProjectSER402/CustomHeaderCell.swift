//
//  CustomHeaderCell.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/24/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {
    

    @IBOutlet weak var appTierLabel: UILabel!
    @IBOutlet weak var expandSectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tag = 200
        expandSectionButton.userInteractionEnabled = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
