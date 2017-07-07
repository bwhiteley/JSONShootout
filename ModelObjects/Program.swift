//
//  Program.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Foundation
//import Marshal
import Unbox
import Mapper
import SwiftyJSON

public struct Program {
    
    let title:String
    let chanId:String
// Date parsing is slow. Remove dates to better measure performance.
//    let startTime:NSDate
//    let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording
    let season:String? // Int?
    let episode:String? // Int?
}


extension Program: Unboxable {
    public init(unboxer: Unboxer) {
        title = unboxer.unbox(key:"Title")
        chanId = unboxer.unbox(key:"Channel.ChanId", isKeyPath: true)
//        startTime = unboxer.unbox(key:"StartTime", formatter:NSDate.ISO8601SecondFormatter)
//        endTime = unboxer.unbox(key:"EndTime", formatter:NSDate.ISO8601SecondFormatter)
        description = unboxer.unbox(key:"Description")
        subtitle = unboxer.unbox(key:"SubTitle")
        recording = unboxer.unbox(key:"Recording")
        season = unboxer.unbox(key:"Season") //  as String?).flatMap({Int($0)})
        episode = unboxer.unbox(key:"Episode") //  as String?).flatMap({Int($0)})
//        season = (unboxer.unbox(key:"Season") as String?).flatMap({Int($0)})
//        episode = (unboxer.unbox(key:"Episode") as String?).flatMap({Int($0)})
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
        season = try map.from("Season") //as String?).flatMap({Int($0)})
        episode = try map.from("Episode") //as String?).flatMap({Int($0)})
//        season = (try map.from("Season") as String?).flatMap({Int($0)})
//        episode = (try map.from("Episode") as String?).flatMap({Int($0)})
    }
}

extension Program { // SwiftyJSON
    public init(json:SwiftyJSON.JSON) {
        title = json["Title"].stringValue
        chanId = json["Channel"]["ChanId"].stringValue
        description = json["Description"].string
        subtitle = json["SubTitle"].string
        season = json["Season"].string // .int
        episode = json["Episode"].string // .int
        recording = Recording(json: json["Recording"])
    }
}
