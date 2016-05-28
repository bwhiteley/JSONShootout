//
//  Program.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Foundation
import Marshal
import Unbox
import Mapper

public struct Program {
    
    let title:String
    let chanId:String
    let startTime:NSDate
    let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording
    let season:Int?
    let episode:Int?
}

extension Program: Unmarshaling {
    public init(object json: MarshaledObject) throws {
        title = try json.valueForKey("Title")
        chanId = try json.valueForKey("Channel.ChanId")
        startTime = try json.valueForKey("StartTime")
        endTime = try json.valueForKey("EndTime")
        description = try json.valueForKey("Description")
        subtitle = try json.valueForKey("SubTitle")
        recording = try json.valueForKey("Recording")
        season = (try json.valueForKey("Season") as String?).flatMap({Int($0)})
        episode = (try json.valueForKey("Episode") as String?).flatMap({Int($0)})
    }
}

extension Program: Unboxable {
    public init(unboxer: Unboxer) {
        title = unboxer.unbox("Title")
        chanId = unboxer.unbox("Channel.ChanId", isKeyPath: true)
        startTime = unboxer.unbox("StartTime", formatter:NSDate.ISO8601SecondFormatter)
        endTime = unboxer.unbox("EndTime", formatter:NSDate.ISO8601SecondFormatter)
        description = unboxer.unbox("Description")
        subtitle = unboxer.unbox("SubTitle")
        recording = unboxer.unbox("Recording")
        season = (unboxer.unbox("Season") as String?).flatMap({Int($0)})
        episode = (unboxer.unbox("Episode") as String?).flatMap({Int($0)})
    }
}

extension Program: Mappable {
    public init(map: Mapper) throws {
        title = try map.from("Title")
        chanId = try map.from("Channel.ChanId")
        startTime = try map.from("StartTime")
        endTime = try map.from("EndTime")
        description = try map.from("Description")
        subtitle = try map.from("SubTitle")
        recording = try map.from("Recording")
        season = (try map.from("Season") as String?).flatMap({Int($0)})
        episode = (try map.from("Episode") as String?).flatMap({Int($0)})
    }
}
