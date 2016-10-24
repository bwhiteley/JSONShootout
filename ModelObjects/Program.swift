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
import SwiftyJSON
import Decodable


public struct Program {
    
    let title:String
    let chanId:String
// Date parsing is slow. Remove dates to better measure performance.
//    let startTime:NSDate
//    let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording
    let season:Int?
    let episode:Int?
}

extension Program: Unmarshaling {
    public init(object json: MarshaledObject) throws {
        title = try json.value(for:"Title")
        chanId = try json.value(for:"Channel.ChanId")
//        startTime = try json.value(for:"StartTime")
//        endTime = try json.value(for:"EndTime")
        description = try json.value(for:"Description")
        subtitle = try json.value(for:"SubTitle")
        recording = try json.value(for:"Recording")
        season = (try json.value(for:"Season") as String?).flatMap({Int($0)})
        episode = (try json.value(for:"Episode") as String?).flatMap({Int($0)})
    }
}

extension Program: Unboxable {
    public init(unboxer: Unboxer) throws {
        title = try unboxer.unbox(key:"Title")
        chanId = try unboxer.unbox(keyPath:"Channel.ChanId")
//        startTime = unboxer.unbox(key:"StartTime", formatter:NSDate.ISO8601SecondFormatter)
//        endTime = unboxer.unbox(key:"EndTime", formatter:NSDate.ISO8601SecondFormatter)
        description = unboxer.unbox(key:"Description")
        subtitle = unboxer.unbox(key:"SubTitle")
        recording = try unboxer.unbox(key:"Recording")
        season = (unboxer.unbox(key:"Season") as String?).flatMap({Int($0)})
        episode = (unboxer.unbox(key:"Episode") as String?).flatMap({Int($0)})
    }
}

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

extension Program: Decodable {
    public static func decode(_ json: Any) throws -> Program {
        return try Program(
            title: json => "Title",
            chanId: json => "Channel" => "ChanId",
//          startTime = json => "StartTime",
//          endTime = json => "EndTime",
            description: json => "Description",
            subtitle: json => "SubTitle",
            recording: json => "Recording",
            season: Int(json => "Season" as String),
            episode: Int(json => "Episode" as String)
        )
    }
}

extension Program { // SwiftyJSON
    public init(json:JSON) {
        title = json["Title"].stringValue
        chanId = json["Channel"]["ChanId"].stringValue
        description = json["Description"].string
        subtitle = json["SubTitle"].string
        season = json["Season"].int
        episode = json["Episode"].int
        recording = Recording(json: json["Recording"])
    }
}
