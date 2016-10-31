//
//  ProgramObject.swift
//  JSONShootout
//
//  Created by Edwin Vermeer on 27/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

public class ProgramObject: NSObject {
    var title:String?
    var chanId:String?
    // Date parsing is slow. Remove dates to better measure performance.
    //    let startTime:NSDate
    //    let endTime:NSDate
    var Description:String?
    var subtitle:String?
    var recording:RecordingObject?
    var season:NSNumber?
    var episode:NSNumber?    
}
