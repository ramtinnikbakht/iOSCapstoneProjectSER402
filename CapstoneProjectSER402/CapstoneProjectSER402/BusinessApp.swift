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
    var appId: String
    var businessAppSys: String
    var businessApp: String
    var appCriticality: String
    var owner: String
    var ownerSys: String
    var businessArea: String
    var businessAreaSys: String
    var businessUnit: String
    var businessUnitSys: String
    var businessSubUnitSys: String
    var businessSubUnit: String
    var ticketCount: Int
    var containsEmergencyTicket: Bool
    
    init(appId: String, businessAppSys: String, businessApp: String, appCriticality: String,
        owner: String, ownerSys: String, businessArea: String, businessAreaSys: String, businessUnit: String,
        businessUnitSys: String, businessSubUnitSys: String, businessSubUnit: String, ticketCount: Int, containsEmergencyTicket: Bool)
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
        self.ticketCount = ticketCount
        self.containsEmergencyTicket = containsEmergencyTicket
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
    
    func getTicketCount() -> Int
    {
        return self.ticketCount
    }
    
    func getContainsEmergencyTicket() -> Bool
    {
        return self.containsEmergencyTicket
    }
    
    // setters
    
    func getAppId(appId: String)
    {
        self.appId = appId
    }
    
    func getBusinessAppSys(businessAppSys: String)
    {
        self.businessAppSys = businessAppSys
    }
    
    func getBusinessApp(businessApp: String)
    {
        self.businessApp = businessApp
    }
    
    func getAppCriticality(appCriticality: String)
    {
        self.appCriticality = appCriticality
    }
    
    func getOwner(owner: String)
    {
        self.owner = owner
    }
    
    func getOwnerSys(ownerSys: String)
    {
        self.ownerSys = ownerSys
    }
    
    func getBusinessArea(businessArea: String)
    {
        self.businessArea = businessArea
    }
    
    func getBusinessAreaSys(businessAreaSys: String)
    {
        self.businessAreaSys = businessAreaSys
    }
    
    func getBusinessUnit(businessUnit: String)
    {
        self.businessUnit = businessUnit
    }
    
    func getBusinessUnitSys(businessUnitSys: String)
    {
        self.businessUnitSys = businessUnitSys
    }
    
    func getBusinessSubUnit(businessSubUnit: String)
    {
        self.businessSubUnit = businessSubUnit
    }
    
    func getBusinessSubUnitSys(businessSubUnitSys: String)
    {
        self.businessSubUnitSys = businessSubUnitSys
    }
    
    func setTicketCount(ticketCount: Int) {
        self.ticketCount = ticketCount
    }
    
    func setContainsEmergencyTicket(containsEmergencyTicket: Bool) {
        self.containsEmergencyTicket = containsEmergencyTicket
    }
    
}