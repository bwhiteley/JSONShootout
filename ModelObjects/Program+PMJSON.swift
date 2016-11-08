//
//  Program+PMJSON.swift
//  JSONShootout
//
//  Created by Kevin Ballard on 11/4/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import PMJSON

extension Program {
    public init(pmjson json: JSON) throws {
        // Should the following 2 default to ""? Seems like they should just throw an error if not present.
        title = try json.getStringOrNil("Title") ?? ""
        chanId = try json.getObjectOrNil("channel", { try $0.getStringOrNil("ChanId") }) ?? ""
        description = try json.getStringOrNil("Description")
        subtitle = try json.getStringOrNil("SubTitle")
        season = try json.toIntOrNil("Season")
        episode = try json.toIntOrNil("Episode")
        recording = try json.getObject("Recording", { try Recording(pmjson: JSON($0)) })
    }
}
