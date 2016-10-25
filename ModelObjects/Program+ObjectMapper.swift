//
//  Program+ObjectMapper.swift
//  JSONShootout
//
//  Created by Denis Bogomolov on 25/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import ObjectMapper

extension Program: ImmutableMappable {
    public init(map: Map) throws {
        title = try map.value("Title")
        chanId = try map.value("Channel.ChanId")
        description = try? map.value("Description")
        subtitle = try? map.value("SubTitle")
        recording = try map.value("Recording")
        season = try? map.value("Season")
        episode = try? map.value("Episode")
    }
    public func mapping(map: Map) {
        title >>> map["Title"]
        chanId >>> map["Channel.ChanId"]
        description >>> map["Description"]
        subtitle >>> map["SubTitle"]
        recording >>> map["Recording"]
        season >>> map["Season"]
        episode >>> map["Episode"]
    }
}
