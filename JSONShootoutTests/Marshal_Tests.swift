//
//  Marshal_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import XCTest
import ModelObjects
import Marshal

class Marshal_Tests: XCTestCase {

    func testDeserialization() {
        self.measure {
            let d:NSDictionary = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }

    func testTypedDeserialization() {
        self.measure {
            let json = try! JSONParser.JSONObjectWithData(self.data as Data)
            XCTAssert(json.count > 0)
        }
    }

    func testDictionaryPerformance() {
        let json = try! JSONParser.JSONObjectWithData(data as Data)

        self.measure {
            let programs:[Program] = try! json.value(for:"ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }

    func testNSDictionaryPerformance() {
        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary

        self.measure {
            //for _ in 0..<10 {
            //while true {
            let programs:[Program] = try! json.value(for: "ProgramList.Programs")
            XCTAssert(programs.count > 1000)
            //}
        }
    }

    func testDeserialization2() {
        self.measure {
            let d: NSArray = try! JSONSerialization.jsonObject(with: self.usersData as Data, options: []) as! NSArray
            XCTAssert(d.count > 0)
        }
    }

    func testTypedDeserialization2() {
        self.measure {
            let json = try! JSONParser.JSONArrayWithData(self.usersData as Data)
            XCTAssert(json.count > 0)
        }
    }

    func testDictionaryPerformance2() {
        let json = try! JSONParser.JSONArrayWithData(self.usersData as Data)

        self.measure {
            let users: [User] = try! json.map(User.init(object:))
            XCTAssert(users.count > 100)
        }
    }

    /*
    func testNSDictionaryPerformance2() {
        let json = try! JSONSerialization.jsonObject(with: self.usersData as Data, options: []) as! NSArray

        self.measure {
            let users: [User] = try! json.map(User.init(object:))
            XCTAssert(users.count > 1000)
        }
    }
    */

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
