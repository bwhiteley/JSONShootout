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
        self.measure {
            let json = try! JSON(data:self.data as Data)
            XCTAssert(json.count > 0)
        }
    }
    
    func testPerformance() {
        let json = try! JSON(data:self.data as Data)
        self.measure {
            let programRA = json["ProgramList"]["Programs"].arrayValue
            let programs = programRA.map(Program.init)
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
}
