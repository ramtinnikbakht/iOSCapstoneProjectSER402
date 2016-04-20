//
//  TicketModel.swift
//  CapstoneProjectSER402
//
//  Created by Nick Krogstad on 3/18/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

weak var tabBar: UITabBar!

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for item in tabBar.items! as [UITabBarItem] {
//            if let image = item.image {
//                item.image = image.imageWithColor(UIColor.yellowColor()).imageWithRenderingMode(.AlwaysOriginal)
//            }
//        }
    }
    
    
}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
