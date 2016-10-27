//
//  Recording+Genome.swift
//  JSONShootout
//
//  Created by Wane Wang on 10/27/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Genome

extension Recording: MappableObject {
    
    public init(map: Map) throws {
        startTsStr = try map.extract("StartTs")
        status = try map.extract("Status") { Status(rawValue: $0) ?? .Unknown }
        recordId = try map.extract("RecordId")
        recGroup = try map.extract("RecGroup") { RecGroup(rawValue: $0) ?? .Unknown }
    }
    
    public func sequence(_ map: Map) throws {
        try startTsStr ~> map["StartTs"]
        try status ~> map["Status"].transformToNode { $0.rawValue }
        try recordId ~> map["RecordId"]
        try recGroup ~> map["RecGroup"].transformToNode { $0.rawValue }
    }
}
