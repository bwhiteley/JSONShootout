//
//  Program+Freddy.swift
//  JSONShootout
//
//  Created by Kartik Patel on 11/24/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Freddy


extension Program: JSONDecodable {
    public init(json: JSON) throws {
        title = try json.getString(at: "Title")
        chanId = try json.getString(at: "Channel", "ChanId")
        description = try json.getString(at: "Description")
        subtitle = try json.getString(at: "SubTitle")
        season = try json.getString(at: "Season").int
        episode = try json.getString(at: "Episode").int
        recording = try Recording(json: json["Recording"]!)
    }
}
