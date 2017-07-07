//
//  Program+SwiftyJSON.swift
//  JSONShootout
//

import SwiftyJSON

extension Program { // SwiftyJSON
    public init(json:JSON) {
        title = json["Title"].stringValue
        chanId = json["Channel"]["ChanId"].stringValue
        description = json["Description"].string
        subtitle = json["SubTitle"].string
        season = json["Season"].int
        episode = json["Episode"].int
        recording = Recording(json: json["Recording"])

//        startTime = Date.fromISO8601String(json["StartTime"].stringValue)!
//        endTime = Date.fromISO8601String(json["EndTime"].stringValue)!
    }
}
