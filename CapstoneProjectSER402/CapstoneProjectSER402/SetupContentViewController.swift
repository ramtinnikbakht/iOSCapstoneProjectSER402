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
    
    var pageIndex: Int!
    var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTitleLabel.text = self.titleText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
