//
//  KeyedMapper_Tests.swift
//  JSONShootout
//
//  Created by Blair McArthur on 6/11/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import KeyedMapper

class KeyedMapper_Tests: XCTestCase {
    func testDeserialization() {
        self.measure {
            let d: NSDictionary = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }

    func testPerformance() {
        let dict = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
        let mapper = KeyedMapper(JSON: dict, type: Program.self)

        self.measure {
            let programs:[Program] = try! mapper.from(.ProgramList)
            XCTAssert(programs.count > 1000)
        }
    }

    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        return data
    }()
}
