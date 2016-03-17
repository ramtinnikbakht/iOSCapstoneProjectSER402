//
//  User.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 2/25/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//
//  Modified by Cuahuctemoc Osorio on 3/2/16


import Foundation

class User
{
    var usersID: String
    var usersName: String
    var usersProfilePic: UIImage
    var usersBusinessUnit: String
    var usersAppList = [String]()
    var usersWatchList = [String]()
    var userChangeList = [String]()
    
    init(usersID: String, usersName: String, usersProfilePic: UIImage, usersBusinessUnit: String, usersAppList: [String], usersWatchList: [String])
    {
        
        self.usersID = usersID
        self.usersName = usersName
        self.usersProfilePic = usersProfilePic
        self.usersBusinessUnit = usersBusinessUnit
        self.usersAppList = usersAppList
        self.usersWatchList = usersWatchList
        
    }
    //Getters
    func getUsersID() -> String
    {
        return self.usersID
    }
    func getUsersNames() -> String
    {
        return self.usersName
    }
    func getUsersProfilePic() -> UIImage
    {
        return self.usersProfilePic
    }
    func getUsersBusinessUnit() -> String
    {
        return self.usersBusinessUnit
    }
    func getUsersID() -> [String]
    {
        return self.usersAppList
    }
    func getUsersNames() -> [String]
    {
        return self.usersWatchList
    }
    //Setters
    func setUsersID(usersID: String)
    {
        self.usersID = usersID
    }
    func setUsersNames(usersName: String)
    {
        self.usersName = usersName
    }
    func setUsersProfilePic(usersProfilePic: UIImage)
    {
        self.usersProfilePic = usersProfilePic
    }
    func setUsersBusinessUnit(usersBusinessUnit: String)
    {
        self.usersBusinessUnit = usersBusinessUnit
    }
    func setUsersID(usersAppList: [String])
    {
        self.usersAppList = usersAppList
    }
    func setUsersNames(usersWatchList: [String])
    {
        self.usersWatchList = usersWatchList
    }
}