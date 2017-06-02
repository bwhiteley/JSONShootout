//
//  Himotoki_Tests.swift
//  JSONShootout
//
//  Created by yudoufu on 2017/05/20.
//  Copyright © 2017年 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import Himotoki

class Himotoki_Tests: XCTestCase {
    func testDeserialization() {
        self.measure {
            let d: NSDictionary = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }

    func testPerormance() {
        let json = try! JSONSerialization.jsonObject(with: self.data, options: [])

        self.measure {
            let programs: [Program] = try! decodeArray(json, rootKeyPath: ["ProgramList", "Programs"])
            XCTAssert(programs.count > 1000)
        }
    }

    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
}
