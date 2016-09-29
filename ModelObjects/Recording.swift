//
//  Recording.swift
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

public struct Recording {
    enum Status: String, UnboxableEnum {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
        
        static func unboxFallbackValue() -> Status {
            return .Unknown
        }
    }
    
    enum RecGroup: String, UnboxableEnum{
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
        
        static func unboxFallbackValue() -> RecGroup {
            return .Unknown
        }
    }
    
    
// Date parsing is slow. Remove dates to better measure performance.
//    let startTs:NSDate?
//    let endTs:NSDate?
    let startTsStr:String
    let status:Status
    let recordId:String
    let recGroup:RecGroup
}

extension Recording: Unmarshaling {
    public init(object json:MarshaledObject) throws {
//        startTs = try? json.value(for:"StartTs")
//        endTs = try? json.value(for:"EndTs")
        startTsStr = try json.value(for:"StartTs")
        recordId = try json.value(for:"RecordId")
        status = (try? json.value(for:"Status")) ?? .Unknown
        recGroup = (try? json.value(for:"RecGroup")) ?? .Unknown
    }
}

extension Recording: Unboxable {
    public init(unboxer: Unboxer) {
//        startTs = unboxer.unbox(key:"StartTs", formatter:NSDate.ISO8601SecondFormatter)
//        endTs = unboxer.unbox(key:"EndTs", formatter:NSDate.ISO8601SecondFormatter)
        startTsStr = unboxer.unbox(key:"StartTs")
        recordId = unboxer.unbox(key:"RecordId")
        status = unboxer.unbox(key: "Status") ?? .Unknown
        recGroup = (unboxer.unbox(key: "RecGroup")) ?? .Unknown
    }
}

extension Recording: Mappable {
    public init(map: Mapper) throws {
//        startTs =  map.optionalFrom("StartTs")
//        endTs =  map.optionalFrom("EndTs")
        startTsStr = try map.from("StartTs")
        recordId = try map.from("RecordId")
        status = map.optionalFrom("Status") ?? .Unknown
        recGroup = map.optionalFrom("RecGroup") ?? .Unknown
    }
}

extension Recording { // SwiftyJSON
    init(json:JSON) {
        startTsStr = json["StartTs"].stringValue
        recordId = json["RecordId"].stringValue
        if let raw = json["Status"].string {
            status = Status(rawValue: raw) ?? .Unknown
        }
        else {
            status = .Unknown
        }
        if let raw = json["RecGroup"].string {
            recGroup = RecGroup(rawValue: raw) ?? .Unknown
        }
        else {
            recGroup = .Unknown
        }
    }
}

