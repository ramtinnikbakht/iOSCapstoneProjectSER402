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
    @IBOutlet weak var expandIndicator: UIImageView!
    @IBOutlet weak var actualStartLabel: UILabel!
    @IBOutlet weak var actualStartValue: UILabel!
    @IBOutlet weak var actualEndLabel: UILabel!
    @IBOutlet weak var actualEndValue: UILabel!
    @IBOutlet weak var businessAppLabel: UILabel!
    @IBOutlet weak var secondaryCCLabel: UILabel!
    @IBOutlet weak var secondaryCCValue: UILabel!
    @IBOutlet weak var expandBackground: UIImageView!
    
    var isObserving = false
    
    class var expandedHeight : CGFloat { get { return 170 } }
    class var defaultHeight : CGFloat { get { return 44 } }
    
    func checkHeight() {
        actualStartLabel.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        actualEndLabel.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        secondaryCCLabel.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        
        actualStartValue.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        actualEndValue.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        secondaryCCValue.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        
        expandBackground.hidden = frame.size.height < ArchiveTableViewCell.expandedHeight
        
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true
        }
        
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false
        }
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    var ticket: ChangeTicket!
        {
        didSet {
            ticketID.text = ticket.number
            businessAppLabel.text = ticket.BusinessApplication
            actualStartValue.text = ticket.actualStart
            actualEndValue.text = ticket.actualEnd
            if (ticket.SecondaryClosureCode == "") {
                secondaryCCValue.text = "Not Applicable"
            } else {
                secondaryCCValue.text = ticket.SecondaryClosureCode
            }

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
