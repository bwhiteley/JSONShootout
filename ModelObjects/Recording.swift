//
//  Recording.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Unbox
import Himotoki

public struct Recording {
    enum Status: String, UnboxableEnum, Decodable {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
    }
    
    enum RecGroup: String, UnboxableEnum, Decodable {
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
    }
    
    
// Date parsing is slow. Remove dates to better measure performance.
//    let startTs:NSDate?
//    let endTs:NSDate?
    let startTsStr:String
    let status:Status
    let recordId:String
    let recGroup:RecGroup
}

