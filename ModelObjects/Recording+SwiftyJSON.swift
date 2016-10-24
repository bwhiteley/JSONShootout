//
//  Recording+SwiftyJSON.swift
//  JSONShootout
//

import SwiftyJSON

extension Recording { // SwiftyJSON
    init(json:JSON) {
        startTsStr = json["StartTs"].stringValue
        recordId = json["RecordId"].stringValue
        if let raw = json["Status"].string {
            status = Status(rawValue: raw) ?? .Unknown
        }
        else {
            status = .Unknown
        }
        if let raw = json["RecGroup"].string {
            recGroup = RecGroup(rawValue: raw) ?? .Unknown
        }
        else {
            recGroup = .Unknown
        }
    }
}

