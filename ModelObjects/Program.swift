//
//  Program.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

public struct Program {
    
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
}

