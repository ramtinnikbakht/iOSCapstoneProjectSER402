//
//  BusinessApp.swift
//  CapstoneProjectSER402
//
//  Created by Colton Rose on 3/7/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation

class BusinessApp
{
    let appId: String
    let businessAppSys: String
    let businessApp: String
    let appCriticality: String
    let owner: String
    let ownerSys: String
    let businessArea: String
    let businessAreaSys: String
    let businessUnit: String
    let businessUnitSys: String
    let businessSubUnitSys: String
    let businessSubUnit: String
    
    init(appId: String, businessAppSys: String, businessApp: String, appCriticality: String,
        owner: String, ownerSys: String, businessArea: String, businessAreaSys: String, businessUnit: String,
        businessUnitSys: String, businessSubUnitSys: String, businessSubUnit: String)
    {
        self.appId = appId
        self.businessAppSys = businessAppSys
        self.businessApp = businessApp
        self.appCriticality = appCriticality
        self.owner = owner
        self.ownerSys = ownerSys
        self.businessArea = businessArea
        self.businessAreaSys = businessAreaSys
        self.businessUnit = businessUnit
        self.businessUnitSys = businessUnitSys
        self.businessSubUnit = businessSubUnit
        self.businessSubUnitSys = businessSubUnitSys
    }
    
    // getters
    func getAppId() -> String
    {
        return self.appId
    }
    
    func getBusinessAppSys() -> String
    {
        return self.businessAppSys
    }
    
    func getBusinessApp() -> String
    {
        return self.businessApp
    }
    
    func getAppCriticality() -> String
    {
        return self.appCriticality
    }
    
    func getOwner() -> String
    {
        return self.owner
    }
    
    func getOwnerSys() -> String
    {
        return self.ownerSys
    }
    
    func getBusinessArea() -> String
    {
        return self.businessArea
    }
    
    func getBusinessAreaSys() -> String
    {
        return self.businessAreaSys
    }
    
    func getBusinessUnit() -> String
    {
        return self.businessUnit
    }
    
    func getBusinessSubUnitSys() -> String
    {
        return self.businessSubUnitSys
    }
    
    func getBusinessSubUnit() -> String
    {
        return self.businessSubUnit
    }
    
    
}