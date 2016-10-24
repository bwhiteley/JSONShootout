//
//  Program+Unbox.swift
//  JSONShootout
//

import Unbox

extension Program: Unboxable {
    public init(unboxer: Unboxer) throws {
        title = try unboxer.unbox(key:"Title")
        chanId = try unboxer.unbox(keyPath:"Channel.ChanId")
        //        startTime = unboxer.unbox(key:"StartTime", formatter:NSDate.ISO8601SecondFormatter)
        //        endTime = unboxer.unbox(key:"EndTime", formatter:NSDate.ISO8601SecondFormatter)
        description = unboxer.unbox(key:"Description")
        subtitle = unboxer.unbox(key:"SubTitle")
        recording = try unboxer.unbox(key:"Recording")
        season = unboxer.unbox(key:"Season")
        episode = unboxer.unbox(key:"Episode")
    }
}

