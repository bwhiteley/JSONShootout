//
//  Program.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

public struct Program: Decodable { // Can't currently conform to Decodable in an extension.
    
    let title:String
    let chanId:String
// Date parsing is slow. Remove dates to better measure performance.
//    let startTime:NSDate
//    let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording
    let season:Int?
    let episode:Int?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case channel = "Channel"
        case description = "Description"
        case subtitle = "SubTitle"
        case recording = "Recording"
        case season = "Season"
        case episode = "Episode"
    }
    
    enum ChannelKeys: String, CodingKey {
        case chanId = "ChanId"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let channel = try values.nestedContainer(keyedBy: ChannelKeys.self, forKey: .channel)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        subtitle = try values.decode(String.self, forKey: .subtitle)
        recording = try values.decode(Recording.self, forKey: .recording)
        season = try values.decodeIfPresent(String.self, forKey: .season).flatMap({Int($0)})
        episode = try values.decodeIfPresent(String.self, forKey: .episode).flatMap({Int($0)})
        chanId = try channel.decode(String.self, forKey: .chanId)
    }
    
}

