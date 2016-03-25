//
//  ChangeTicket_Table_Template.swift
//  CapstoneProjectSER402
//
//  Created by Cuahuc on 3/3/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation

class ChangeTicket_Table_Template
{
    var id : String?
    var priority : String
    var startDate: String
    var icon: UIImage?
    var isWatched: Bool
    var requestedByGroupBusinessUnit: String
    var requestedByGroupSubBusinessUnit: String
    
    init(id: String, priority: String, startDate: String, icon: UIImage, isWatched: Bool, requestedByGroupBusinessUnit: String, requestedByGroupSubBusinessUnit: String)
    {
        self.id = id
        self.priority = priority
        self.startDate = startDate
        self.icon = icon
        self.isWatched = isWatched
        self.requestedByGroupBusinessUnit = requestedByGroupBusinessUnit
        self.requestedByGroupSubBusinessUnit = requestedByGroupSubBusinessUnit
    }
    
    func getId() -> String
    {
        return self.id!
    }
    func getPriority() -> String
    {
        return self.priority
    }
    func getStartDate() -> String
    {
        return self.startDate
    }
    func getIcon() -> UIImage
    {
        return self.icon!
    }
    func getIsWatched() -> Bool
    {
        return self.isWatched
    }
    func getRequestedByGroupBusinessUnit() -> String
    {
        return self.requestedByGroupBusinessUnit
    }
    func getRequestedByGroupSubBusinessUnit() -> String
    {
        return self.requestedByGroupSubBusinessUnit
    }
    
    func setId(id: String)
    {
        self.id = id
    }
    func setPriority(priority: String)
    {
        self.priority = priority
    }
    func setStartDate(startDate: String)
    {
        self.startDate = startDate
    }
    func setIcon(icon: UIImage)
    {
        self.icon = icon
    }
    func setIsWatched(isWatched: Bool)
    {
        self.isWatched = isWatched
    }
    func setRequestedByGroupBusinessUnit(requestedByGroupBusinessUnit: String)
    {
        self.requestedByGroupBusinessUnit = requestedByGroupBusinessUnit
    }
    func setRequestedByGroupSubBusinessUnit(requestedByGroupSubBusinessUnit: String)
    {
        self.requestedByGroupSubBusinessUnit = requestedByGroupSubBusinessUnit
    }
}