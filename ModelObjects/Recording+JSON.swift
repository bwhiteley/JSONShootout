//
//  Recording+JSON.swift
//  JSONShootout
//

import JSON

extension Recording: JSONInitializable {

  public init(json: JSON) throws {

    self.startTsStr = try json.get("StartTs")
    self.recordId   = try json.get("RecordId")
    self.status     = try json.get("Status", default: Status.Unknown)
    self.recGroup   = try json.get("RecGroup", default: RecGroup.Unknown)
  }
}
