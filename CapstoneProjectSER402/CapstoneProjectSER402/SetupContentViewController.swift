//
//  SetupContentViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 2/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class SetupContentViewController: UIViewController {

    @IBOutlet var setupTitleLabel: UILabel!
    
    @IBOutlet var setupDescriptionLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    var descriptionText: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTitleLabel.text = self.titleText
        self.setupDescriptionLabel.text = self.descriptionText
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
