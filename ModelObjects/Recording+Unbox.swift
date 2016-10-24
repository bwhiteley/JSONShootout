//
//  Recording+Unbox.swift
//  JSONShootout
//

import Unbox

extension Recording: Unboxable {
    public init(unboxer: Unboxer) throws {
        //        startTs = unboxer.unbox(key:"StartTs", formatter:NSDate.ISO8601SecondFormatter)
        //        endTs = unboxer.unbox(key:"EndTs", formatter:NSDate.ISO8601SecondFormatter)
        startTsStr = try unboxer.unbox(key:"StartTs")
        recordId = try unboxer.unbox(key:"RecordId")
        status = unboxer.unbox(key: "Status") ?? .Unknown
        recGroup = (unboxer.unbox(key: "RecGroup")) ?? .Unknown
    }
}

