//
//  Recording+Argo.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 7/7/17.
//  Copyright © 2017 SwiftBit. All rights reserved.
//

import Foundation

import Argo
import Runes
import Curry

extension Recording.RecGroup: Decodable {}
extension Recording.Status: Decodable {}

extension Recording: Decodable {
    public static func decode(_ json: Argo.JSON) -> Decoded<Recording> {
        return curry(Recording.init)
            <^> json <| "StartTs"
            <*> json <|? "Status"
            <*> json <| "RecordId"
            <*> json <|? "RecGroup"
    }
}

