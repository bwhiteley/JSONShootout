//
//  Program+Mapper.swift
//  JSONShootout
//

import Mapper

extension Program: Mappable {
    public init(map: Mapper) throws {
        title = try map.from("Title")
        chanId = try map.from("Channel.ChanId")
        //        startTime = try map.from("StartTime")
        //        endTime = try map.from("EndTime")
        description = try map.from("Description")
        subtitle = try map.from("SubTitle")
        recording = try map.from("Recording")
        season = (try map.from("Season") as String?).flatMap({Int($0)})
        episode = (try map.from("Episode") as String?).flatMap({Int($0)})
    }
}
