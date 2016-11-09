//
//  Recording+Mapper.swift
//  JSONShootout
//

import Mapper

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
