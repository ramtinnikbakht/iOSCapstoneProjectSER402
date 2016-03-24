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
    
    func addWatchedTickets(ticket: WatchedTicket) {
        watchedTickets += [ticket]
        print(watchedTickets.count)
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
    
}

class TicketTabBarController:UITabBarController {
    let wTickets = TicketModel()
}
