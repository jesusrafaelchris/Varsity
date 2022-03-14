//
//  userInfo.swift
//  Varisty
//
//  Created by Christian Grinling on 22/12/2020.
//

import UIKit

class userInfo: NSObject {
    
    @objc var name: String?
    @objc var Course: String?
    @objc var University: String?
    @objc var uid:String?
    @objc var profilePictureURL: String?
    @objc var username: String?
   // @objc var BioText: String?
    @objc var Year: String?
    @objc var Created: NSDate?
    //@objc var countryFlag: String?
    //@objc var NotificationToken: String?
    
    init(dictionary: [String: AnyObject]) {
        self.name = dictionary["name"] as? String
        self.Course = dictionary["Course"] as? String
        self.University = dictionary["University"] as? String
        self.uid = dictionary["uid"] as? String
        self.Year = dictionary["Year"] as? String
        self.profilePictureURL = dictionary["profilePictureURL"] as? String
        //self.BioText = dictionary["BioText"] as? String
        self.Created = dictionary["Created"] as? NSDate
        //self.countryFlag = dictionary["countryFlag"] as? String
       // self.NotificationToken = dictionary["NotificationToken"] as? String
    }
}
