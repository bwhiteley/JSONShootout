//
//  SwiftyJSON_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 6/1/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import SwiftyJSON

class SwiftyJSON_Tests: XCTestCase {
    
    func testDeserialization() {
        self.measureBlock {
            let json = JSON(data:self.data)
            XCTAssert(json.count > 0)
        }
    }
    
    func testPerformance() {
        let json = JSON(data:self.data)
        self.measureBlock {
            let programRA = json["ProgramList"]["Programs"].arrayValue
            let programs = programRA.map(Program.init)
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:NSData = {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Large", ofType: "json")
        let data = NSData(contentsOfFile: path!)!
        return data
    }()
    
}
