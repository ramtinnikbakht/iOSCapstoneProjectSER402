//
//  AppsOptionTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/29/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppsOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var clearSelectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectAllButton?.layer.borderWidth = 1.0
        selectAllButton?.layer.borderColor = UIColor(red: 0/255.0,
        green: 64/255.0,
        blue: 128/255.0,
        alpha: 1.0).CGColor
        selectAllButton?.layer.cornerRadius = 8.0
        selectAllButton?.layer.masksToBounds = true
        
        clearSelectionButton?.layer.borderWidth = 1.0
        clearSelectionButton?.layer.borderColor = UIColor(red: 0/255.0,
                                                     green: 64/255.0,
                                                     blue: 128/255.0,
                                                     alpha: 1.0).CGColor
        clearSelectionButton?.layer.cornerRadius = 8.0
        clearSelectionButton?.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
