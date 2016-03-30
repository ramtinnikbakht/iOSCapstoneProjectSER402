//
//  BusinessApp_Table_Template.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation

class BusinessApp_Table_Template
{
    var appName : String?
    var ticketCount : Int
    var containsEmergencyTicket : Bool
    var icon : UIImage
    var appCriticality : Int
    
    init(appName: String, ticketCount: Int, containsEmergencyTicket: Bool, icon: UIImage, appCriticality: Int)
    {
        self.appName = appName
        self.ticketCount = ticketCount
        self.containsEmergencyTicket = containsEmergencyTicket
        self.icon = icon
        self.appCriticality = appCriticality
    }
    
    func getAppName() -> String
    {
        return self.appName!
    }
    func getTicketCount() -> Int
    {
        return self.ticketCount
    }
    func getContainsEmergencyTicket() -> Bool
    {
        return self.containsEmergencyTicket
    }
    func getIcon() -> UIImage {
        return self.icon
    }
    func getAppCriticality() -> Int
    {
        return self.appCriticality
    }
    
    func setAppName(appName: String)
    {
        self.appName = appName
    }
    
    func setTicketCount(ticketCount: Int)
    {
        self.ticketCount = ticketCount
    }
    
    func setContainsEmergencyTicket(containsEmergencyTicket: Bool)
    {
        self.containsEmergencyTicket = containsEmergencyTicket
    }
    
    func getIcon(icon: UIImage)
    {
        self.icon = icon
    }
    
    func setAppCriticality(appCriticality: Int)
    {
        self.appCriticality = appCriticality
    }
}

