//
//  Recording+Freddy.swift
//  JSONShootout
//
//  Created by Kartik Patel on 11/25/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Freddy

extension Recording {
    public init(json: JSON) throws {
        startTsStr = try json.getString(at: "StartTs")
        recordId = try json.getString(at: "RecordId")
        status = try Status(rawValue: json.getString(at: "Status")) ?? .Unknown
        recGroup = try RecGroup(rawValue: json.getString(at: "RecGroup")) ?? .Unknown
    }
}


