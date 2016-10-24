//
//  Recording+Marshal.swift
//  JSONShootout
//

import Marshal

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

