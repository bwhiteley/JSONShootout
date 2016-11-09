
//
//  User+JSON.swift
//  JSONShootout
//

import JSON

extension User.Friend: JSONInitializable {

  public init(json: JSON) throws {
    self.id   = try json.get("id")
    self.name = try json.get("name")
  }
}

extension User: JSONInitializable {

  public init(json: JSON) throws {
    self.id             = try json.get("_id")
    self.index          = try json.get("index")
    self.guid           = try json.get("guid")
    self.isActive       = try json.get("isActive")
    self.balance        = try json.get("balance")
    self.picture        = try json.get("picture")
    self.age            = try json.get("age")
    self.eyeColor       = try json.get("eyeColor")
    self.name           = try json.get("name")
    self.gender         = try json.get("gender")
    self.company        = try json.get("company")
    self.email          = try json.get("email")
    self.phone          = try json.get("phone")
    self.address        = try json.get("address")
    self.about          = try json.get("about")
    self.registered     = try json.get("registered")
    self.latitude       = try json.get("latitude")
    self.longitude      = try json.get("longitude")
    self.tags           = try json.get("tags")
    self.friends        = try json.get("friends")
    self.greeting       = try json.get("greeting")
    self.favoriteFruit  = try json.get("favoriteFruit")
  }
}
