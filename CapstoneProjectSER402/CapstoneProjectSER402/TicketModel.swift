//
//  TicketModel.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/18/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class TicketModel:NSObject {
    var watchedTickets = [WatchedTicket]()
    var changeTickets = [ChangeTicket_Table_Template]()
    
    func addWatchedTickets(ticket: WatchedTicket) {
        watchedTickets += [ticket]
    }
    
    func removeWatchedTicket(selectedID: String) {
        var index = 0
        for ticket in watchedTickets {
            if (ticket.id == selectedID) {
                watchedTickets.removeAtIndex(index)
            } else {
                index+=1
            }
        }
    }
    
    func addChangeTickets(ticket: ChangeTicket_Table_Template) {
        changeTickets += [ticket]
    }
    
    func removeChangeTicket(selectedID: String) {
        var index = 0
        for ticket in changeTickets {
            if (ticket.id == selectedID) {
                changeTickets.removeAtIndex(index)
            } else {
                index+=1
            }
        }
    }
    
}

class TicketTabBarController:UITabBarController {
    let wTickets = TicketModel()
}
