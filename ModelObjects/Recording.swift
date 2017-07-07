//
//  Recording.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Unbox

public struct Recording: Decodable { // Can't currently conform to Decodable in an extension. 
    enum Status: String, UnboxableEnum {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
    }
    
    enum RecGroup: String, UnboxableEnum {
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
    }
    
    
// Date parsing is slow. Remove dates to better measure performance.
//    let startTs:NSDate?
//    let endTs:NSDate?
    let startTsStr:String
    let status:Status
    let recordId:String
    let recGroup:RecGroup
    
    
    enum CodingKeys: String, CodingKey {
        case startTsStr = "StartTs"
        case recordId = "RecordId"
        case status = "Status"
        case recGroup = "RecGroup"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        startTsStr = try values.decode(forKey: .startTsStr)
        status = try values.decode(forKey: .status).flatMap(Status.init) ?? .Unknown
        recGroup = try values.decode(forKey: .recGroup).flatMap(RecGroup.init) ?? .Unknown
        recordId = try values.decode(forKey: .recordId)
    }
    
}

extension KeyedDecodingContainer {
    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try decode(T.self, forKey: key)
    }
    func decode<T: Decodable>(forKey key: Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
}

