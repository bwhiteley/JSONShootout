//
//  Recording+Decodable.swift
//  JSONShootout
//
//  Created by Alessandro Orrù on 25/10/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Foundation
import Decodable


extension Recording : Decodable {
    public static func decode(_ json: Any) throws -> Recording {
        return try Recording(
//            startTs: json => "StartTs",
//            endTs: json => "EndTs",
            startTsStr: json => "StartTs",
            status: Status(rawValue: json => "Status") ?? .Unknown,
            recordId: json => "RecordId",
            recGroup: RecGroup(rawValue: json => "RecGroup") ?? .Unknown
        )
    }
}
