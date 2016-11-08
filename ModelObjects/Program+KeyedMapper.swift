//
//  Program+KeyedMapper.swift
//  JSONShootout
//

import KeyedMapper

extension Program: Mappable {
    public enum Key: String, JSONKey {
        case Title
        case ChannelID = "Channel.ChanId"
        case Description
        case SubTitle
        case Recording
        case Season
        case Episode
        case ProgramList = "ProgramList.Programs"
    }

    public init(map: KeyedMapper<Program>) throws {
        title = try map.from(.Title)
        chanId = try map.from(.ChannelID)
        description = map.optionalFrom(.Description)
        subtitle = map.optionalFrom(.SubTitle)
        recording = try map.from(.Recording)
        season = map.optionalFrom(.Season, transformation: { Int($0 as! String)! })
        episode = map.optionalFrom(.Episode, transformation: { Int($0 as! String)! })
    }
}
