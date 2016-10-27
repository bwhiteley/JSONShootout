//
//  Program+Genome.swift
//  JSONShootout
//
//  Created by Wane Wang on 10/27/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import Genome

extension Program: MappableObject {
    
    public init(map: Map) throws {
        title = try map.extract("Title") {
            $0 ?? ""
        }
        chanId = try map.extract("channel", "ChanId") {
            $0 ?? ""
        }
        description = try map.extract("Description")
        subtitle = try map.extract("SubTitle")
        season = try map.extract("Season")
        episode = try map.extract("Episode")
        recording = try Recording(node: try map.extract("Recording"))
    }
    
    public func sequence(_ map: Map) throws {
        
    }
    
}
