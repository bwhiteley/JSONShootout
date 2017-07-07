//
//  Program+Argo.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 7/7/17.
//  Copyright © 2017 SwiftBit. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

extension Program: Decodable {
    public static func decode(_ json: Argo.JSON) -> Decoded<Program> {
        return curry(Program.init)
            <^> json <| "Title"
            <*> json <| ["Channel", "ChanId"]
            <*> json <|? "Description"
            <*> json <|? "SubTitle"
            <*> json <| "Recording"
            <*> json <|? "Season"
            <*> json <|? "Episode"
        
    }
}

