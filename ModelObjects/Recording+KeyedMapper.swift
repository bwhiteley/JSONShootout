//
//  Recording+KeyedMapper.swift
//  JSONShootout
//

import KeyedMapper

extension Recording: Mappable {
    public enum Key: String, JSONKey {
        case StartTs
        case RecordId
        case Status
        case RecGroup
    }

    public init(map: KeyedMapper<Recording>) throws {
        //        startTs =  map.optionalFrom("StartTs")
        //        endTs =  map.optionalFrom("EndTs")
        startTsStr = try map.from(.StartTs)
        recordId = try map.from(.RecordId)
        status = map.optionalFrom(.Status) ?? .Unknown
        recGroup = map.optionalFrom(.RecGroup) ?? .Unknown
    }
}
