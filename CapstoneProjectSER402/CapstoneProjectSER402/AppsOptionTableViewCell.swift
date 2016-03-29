//
//  AppsOptionTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/29/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppsOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var selectAllSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
