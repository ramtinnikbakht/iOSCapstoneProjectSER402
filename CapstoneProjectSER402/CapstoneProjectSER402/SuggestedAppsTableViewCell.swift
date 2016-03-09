//
//  SuggestedAppsTableViewCell.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/8/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class SuggestedAppsTableViewCell: UITableViewCell {

    @IBOutlet var selectionButton: UIButton!
    @IBOutlet var appsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let uncheckedCircleImage = UIImage(named: "unchecked-circle")
        selectionButton.setImage(uncheckedCircleImage, forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
