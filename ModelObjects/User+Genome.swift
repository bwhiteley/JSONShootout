//
//  User+Genome.swift
//  JSONShootout
//
//  Created by Wane Wang on 11/8/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Genome

extension User.Friend: MappableObject {
    public init(map: Map) throws {
        self.id             = try map.extract("id")
        self.name           = try map.extract("name")
    }
    
    public func sequence(_ map: Map) throws { }
}

extension User: MappableObject {
    
    public init(map: Map) throws {
        self.id             = try map.extract("_id")
        self.index          = try map.extract("index")
        self.guid           = try map.extract("guid")
        self.isActive       = try map.extract("isActive")
        self.balance        = try map.extract("balance")
        self.picture        = try map.extract("picture")
        self.age            = try map.extract("age")
        self.eyeColor       = try map.extract("eyeColor") { User.Color(rawValue: $0) ?? .red }
        self.name           = try map.extract("name")
        self.gender         = try map.extract("gender") { User.Gender(rawValue: $0) ?? .male }
        self.company        = try map.extract("company")
        self.email          = try map.extract("email")
        self.phone          = try map.extract("phone")
        self.address        = try map.extract("address")
        self.about          = try map.extract("about")
        self.registered     = try map.extract("registered")
        self.latitude       = try map.extract("latitude")
        self.longitude      = try map.extract("longitude")
        self.tags           = try map.extract("tags")
        self.friends        = try map.extract("friends")
        self.greeting       = try map.extract("greeting")
        self.favoriteFruit  = try map.extract("favoriteFruit")
    }
    
    public func sequence(_ map: Map) throws {
        
    }
    
}
