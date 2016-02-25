//
//  User.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 2/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import Foundation

class User {
    var usersID: Int
    var usersName: String
    var usersProfilePic: UIImage
    var usersBusinessUnit: String
    var usersAppList = [String]()
    var usersWatchList = [String]()
    
    init(usersID: Int, usersName: String, usersProfilePic: UIImage, usersBusinessUnit: String, usersAppList: [String], usersWatchList: [String]) {
        
        self.usersID = usersID
        self.usersName = usersName
        self.usersProfilePic = usersProfilePic
        self.usersBusinessUnit = usersBusinessUnit
        self.usersAppList = usersAppList
        self.usersWatchList = usersWatchList
        
    }
}