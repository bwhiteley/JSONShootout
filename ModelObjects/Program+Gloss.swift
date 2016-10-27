//
//  Program+Gloss.swift
//  JSONShootout
//

import Gloss

extension Program: Decodable {

    public init?(json: JSON) {

        title       = "Title" <~~ json ?? ""
        chanId      = "channel.ChanId" <~~ json ?? ""
        description = "Description" <~~ json
        subtitle    = "SubTitle" <~~ json
        season      = "Season" <~~ json
        episode     = "Episode" <~~ json
        recording   = ("Recording" <~~ json)!
    }
}
