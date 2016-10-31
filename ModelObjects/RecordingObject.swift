//
//  RecordingObject.swift
//  JSONShootout
//
//  Created by Edwin Vermeer on 27/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

class RecordingObject: NSObject {
    enum Status: String {
        case None = "0"
        case Recorded = "-3"
        case Recording = "-2"
        case Unknown
    }
    
    enum RecGroup: String {
        case Deleted = "Deleted"
        case Default = "Default"
        case LiveTV = "LiveTV"
        case Unknown
    }
    
    // Date parsing is slow. Remove dates to better measure performance.
    //    var startTs:NSDate?
    //    var endTs:NSDate?
    var startTsStr:String?
    var status:Status?
    var recordId:String?
    var recGroup:RecGroup?
}
