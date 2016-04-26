//
//  BusinessArea.swift
//  CapstoneProjectSER402
//
//  Created by Cuahuc on 4/22/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation


class BusinessArea
{
    var name: String
    var sysID: String
    
    init(name: String, sysID: String)
    {
        self.name = name
        self.sysID = sysID
    }
    
    func getName() -> String
    {
        return self.name
    }
    func getSysID() -> String
    {
        return self.sysID
    }
    func setName(name: String)
    {
        self.name = name
    }
    func setSysID(sysID: String)
    {
        self.sysID = sysID
    }
}