//
//  Program+Himotoki.swift
//  JSONShootout
//
//  Created by yudoufu on 2017/05/20.
//  Copyright © 2017年 SwiftBit. All rights reserved.
//

import Himotoki

extension Program: Decodable {
    public static func decode(_ e: Extractor) throws -> Program {
        return try Program(
            title: e <| "Title",
            chanId: e <| ["Channel", "ChanId" ],
            description: e <|? "Description",
            subtitle: e <|? "SubTitle",
            recording: e <| "Recording",
            season: (e <|? "Season" as String?).flatMap { Int($0) },
            episode: (e <|? "Episode" as String?).flatMap { Int($0) }
        )
    }
}
