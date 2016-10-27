//
//  Recording+ObjectMapper.swift
//  JSONShootout
//
//  Created by Denis Bogomolov on 25/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import ObjectMapper

extension Recording: ImmutableMappable {
    public init(map: Map) throws {
        startTsStr = try map.value("StartTs")
        status = (try? map.value("Status")) ?? .Unknown
        recordId = try map.value("RecordId")
        recGroup = (try? map.value("RecGroup")) ?? .Unknown
    }
    public func mapping(map: Map) {
        startTsStr >>> map["StartTs"]
        status >>> map["Status"]
        recordId >>> map["RecordId"]
        recGroup >>> map["RecGroup"]
    }
}
