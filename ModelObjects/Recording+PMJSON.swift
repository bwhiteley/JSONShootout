//
//  Recording+PMJSON.swift
//  JSONShootout
//
//  Created by Kevin Ballard on 11/4/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import PMJSON

extension Recording {
    public init(pmjson json: JSON) throws {
        startTsStr = try json.getString("StartTs")
        recordId = try json.getString("RecordId")
        status = try json.getStringOrNil("Status").flatMap({ Status(rawValue: $0) }) ?? .Unknown
        recGroup = try json.getStringOrNil("RecGroup").flatMap({ RecGroup(rawValue: $0) }) ?? .Unknown
    }
}
