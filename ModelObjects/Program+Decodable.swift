//
//  Program+Decodable.swift
//  JSONShootout
//
//  Created by Alessandro Orrù on 25/10/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Foundation
import Decodable

extension Program: Decodable {
    public static func decode(_ json: Any) throws -> Program {
        return try Program(
            title: json => "Title",
            chanId: json => "Channel" => "ChanId",
            //          startTime = json => "StartTime",
            //          endTime = json => "EndTime",
            description: json => "Description",
            subtitle: json => "SubTitle",
            recording: json => "Recording",
            season: Int(json => "Season" as String),
            episode: Int(json => "Episode" as String)
        )
    }
}
