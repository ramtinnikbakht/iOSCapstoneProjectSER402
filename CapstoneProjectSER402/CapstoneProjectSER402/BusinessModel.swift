//
//  BusinessModel.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class BusinessModel:NSObject {
    var businessApps = [BusinessApp_Table_Template]()
    
    func addBusinessApp(app: BusinessApp_Table_Template) {
        businessApps += [app]
    }
    
    func removeBusinessApp(selectedID: String) {
        var index = 0
        for app in businessApps {
            if (app.appName == selectedID) {
                businessApps.removeAtIndex(index)
            } else {
                index+=1
            }
        }
    }
    
}
