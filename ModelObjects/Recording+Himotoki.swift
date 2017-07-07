//
//  Recording+Himotoki.swift
//  JSONShootout
//
//  Created by yudoufu on 2017/05/20.
//  Copyright © 2017年 SwiftBit. All rights reserved.
//

import Himotoki

extension Recording: Decodable {
    public static func decode(_ e: Extractor) throws -> Recording {
        return try Recording(
            startTsStr: e <| "StartTs",
            status: (try? e <| "Status") ?? .Unknown,
            recordId: e <| "RecordId",
            recGroup: (try? e <| "RecGroup") ?? .Unknown
        )
    }
}
