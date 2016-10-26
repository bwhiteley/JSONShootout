//
//  Program+JSON.swift
//  JSONShootout
//

import JSON

extension Program: JSONInitializable {

    public init(json:JSON) throws {

        title       = try json.get("Title", default: "")
        chanId      = try json["channel"]?.get("ChanId", default: "") ?? ""
        description = try json.get("Description")
        subtitle    = try json.get("SubTitle")
        season      = try json.get("Season")
        episode     = try json.get("Episode")
        recording   = try json.get("Recording")
    }
}
