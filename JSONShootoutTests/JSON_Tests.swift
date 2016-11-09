//
//  SwiftyJSON_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 6/1/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import JSON

class JSON_Tests: XCTestCase {

  func testDeserialization() {
      self.measure {
        do {

          let json = try JSON.Parser.parse(self.data)

          XCTAssert((json.object?.count ?? 0) > 0)
        } catch {
          XCTFail("Failed to parse: \(error)")
        }
      }
  }

  func testPerformance() {
    do {

      let json = try JSON.Parser.parse(self.data)

      self.measure {
        do {

          let programRA = json["ProgramList"]?["Programs"]?.array ?? []
          let programs = try programRA.map(Program.init)
          XCTAssert(programs.count > 1000)
        } catch {
          XCTFail("Mapping did fail: \(error)")
        }
      }

    } catch {
      XCTFail("Failed to parse: \(error)")
    }
  }

  func testDeserialization2() {
    self.measure {
      do {

        let json = try JSON.Parser.parse(self.usersData)

        XCTAssert((json.array?.count ?? 0) > 0)
      } catch {
        XCTFail("Failed to parse: \(error)")
      }
    }
  }

  func testPerformance2() {
    do {

      let json = try JSON.Parser.parse(self.usersData)

      self.measure {
        do {

          let users = try json.map(User.init)
          XCTAssert(users.count > 100)
        } catch {
          XCTFail("Mapping did fail: \(error)")
        }
      }
    } catch {
      XCTFail("Failed to parse: \(error)")
    }
  }

  private lazy var data:Data = {
    let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
    let data = try! Data(contentsOf: path!)
    return data
  }()

  private lazy var usersData:Data = {
    let path = Bundle(for: type(of: self)).url(forResource: "Users", withExtension: "json")
    let data = try! Data(contentsOf: path!)
    return data
  }()

}
