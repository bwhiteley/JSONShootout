//
//  User+Mapper.swift
//  JSONShootout
//
//  Created by Wane Wang on 11/9/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Mapper

extension User.Friend: Mappable {
    public init(map: Mapper) throws {
        self.id             = try map.from("id")
        self.name           = try map.from("name")
    }
}

extension User: Mappable {
    
    public init(map: Mapper) throws {
        self.id             = try map.from("_id")
        self.index          = try map.from("index")
        self.guid           = try map.from("guid")
        self.isActive       = try map.from("isActive")
        self.balance        = try map.from("balance")
        self.picture        = try map.from("picture")
        self.age            = try map.from("age")
        self.eyeColor       = map.optionalFrom("eyeColor") ?? .red
        self.name           = try map.from("name")
        self.gender         = map.optionalFrom("gender") ?? .male
        self.company        = try map.from("company")
        self.email          = try map.from("email")
        self.phone          = try map.from("phone")
        self.address        = try map.from("address")
        self.about          = try map.from("about")
        self.registered     = try map.from("registered")
        self.latitude       = try map.from("latitude")
        self.longitude      = try map.from("longitude")
        self.tags           = try map.from("tags")
        self.friends        = try map.from("friends")
        self.greeting       = try map.from("greeting")
        self.favoriteFruit  = try map.from("favoriteFruit")
    }
    
}
