//
//  Recording.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Unbox

public struct Recording {
    enum Status: String, UnboxableEnum {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
    }
    
    enum RecGroup: String, UnboxableEnum {
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
    }
    
    
// Date parsing is slow. Remove dates to better measure performance.
//    let startTs:Date?
//    let endTs:Date?
    let startTsStr:String
    let status:Status
    let recordId:String
    let recGroup:RecGroup
}

