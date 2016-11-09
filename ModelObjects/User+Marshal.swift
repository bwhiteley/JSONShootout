//
//  User+Marshal.swift
//  JSONShootout
//

import Marshal

extension User.Friend: Unmarshaling {

  public init(object json: MarshaledObject) throws {
    self.id   = try json.value(for: "id")
    self.name = try json.value(for: "name")
  }
}

extension User: Unmarshaling {

  public init(object json: MarshaledObject) throws {
    self.id             = try json.value(for: "_id")
    self.index          = try json.value(for: "index")
    self.guid           = try json.value(for: "guid")
    self.isActive       = try json.value(for: "isActive")
    self.balance        = try json.value(for: "balance")
    self.picture        = try json.value(for: "picture")
    self.age            = try json.value(for: "age")
    self.eyeColor       = try json.value(for: "eyeColor")
    self.name           = try json.value(for: "name")
    self.gender         = try json.value(for: "gender")
    self.company        = try json.value(for: "company")
    self.email          = try json.value(for: "email")
    self.phone          = try json.value(for: "phone")
    self.address        = try json.value(for: "address")
    self.about          = try json.value(for: "about")
    self.registered     = try json.value(for: "registered")
    self.latitude       = try json.value(for: "latitude")
    self.longitude      = try json.value(for: "longitude")
    self.tags           = try json.value(for: "tags")
    self.friends        = try json.value(for: "friends")
    self.greeting       = try json.value(for: "greeting")
    self.favoriteFruit  = try json.value(for: "favoriteFruit")
  }
}
