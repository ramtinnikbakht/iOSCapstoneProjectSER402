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
    
    init(id: String, priority: String, startDate: String, icon: UIImage, isWatched: Bool)
    {
        self.id = id
        self.priority = priority
        self.startDate = startDate
        self.icon = icon
        self.isWatched = isWatched
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
}