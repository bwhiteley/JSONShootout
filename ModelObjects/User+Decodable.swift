//
//  User+Decodable.swift
//  JSONShootout
//
//  Created by Wane Wang on 11/9/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Decodable

extension User.Friend: Decodable {
    
    public static func decode(_ json: Any) throws -> User.Friend {
        return try User.Friend(
            id: json => "id",
            name: json => "name"
        )
    }
}

extension User: Decodable {
    
    public static func decode(_ json: Any) throws -> User {
        return try User(
            id            : json => "_id",
            index         : json => "index",
            guid          : json => "guid",
            isActive      : json => "isActive",
            balance       : json => "balance",
            picture       : json => "picture",
            age           : json => "age",
            eyeColor      : User.Color(rawValue: json => "eyeColor")  ?? .red,
            name          : json => "name",
            gender        : User.Gender(rawValue: json => "gender") ?? .male,
            company       : json => "company",
            email         : json => "email",
            phone         : json => "phone",
            address       : json => "address",
            about         : json => "about",
            registered    : json => "registered",
            latitude      : json => "latitude",
            longitude     : json => "longitude",
            tags          : json => "tags",
            friends       : json => "friends",
            greeting      : json => "greeting",
            favoriteFruit : json => "favoriteFruit"
        )
    }
    
}
