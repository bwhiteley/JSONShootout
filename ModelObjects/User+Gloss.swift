//
//  User+Gloss.swift
//  JSONShootout
//
//  Created by Wane Wang on 11/9/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Gloss

extension User.Friend: Decodable {
    public init?(json: JSON) {
        self.id             = "id" <~~ json ?? 0
        self.name           = "name" <~~ json ?? ""
    }
}

extension User: Decodable {
    
    public init?(json: JSON) {
        self.id             = "_id" <~~ json ?? ""
        self.index          = "index" <~~ json ?? 0
        self.guid           = "guid" <~~ json ?? ""
        self.isActive       = "isActive" <~~ json ?? false
        self.balance        = "balance" <~~ json ?? ""
        self.picture        = "picture" <~~ json ?? ""
        self.age            = "age" <~~ json ?? 0
        self.eyeColor       = "eyeColor" <~~ json ?? .red
        self.name           = "name" <~~ json ?? ""
        self.gender         = "gender" <~~ json ?? .male
        self.company        = "company" <~~ json ?? ""
        self.email          = "email" <~~ json ?? ""
        self.phone          = "phone" <~~ json ?? ""
        self.address        = "address" <~~ json ?? ""
        self.about          = "about" <~~ json ?? ""
        self.registered     = "registered" <~~ json ?? ""
        self.latitude       = "latitude" <~~ json ?? 0
        self.longitude      = "longitude" <~~ json ?? 0
        self.tags           = "tags" <~~ json ?? []
        self.friends        = "friends" <~~ json ?? []
        self.greeting       = "greeting" <~~ json ?? ""
        self.favoriteFruit  = "favoriteFruit" <~~ json ?? ""
    }
    
}
