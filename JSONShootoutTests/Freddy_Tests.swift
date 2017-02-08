//
//  Freddy_Tests.swift
//  JSONShootout
//
//  Created by Kartik Patel on 11/24/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import Freddy

class Freddy_Tests: XCTestCase {
    
    func testDeserialization() {
        self.measure {
            let json = try! JSON(data:self.data as Data)
            XCTAssert(try! json.getDictionary().count > 0)
        }
    }
    
    func testPerformance() {
        let json = try! JSON(data:self.data as Data)
        
        self.measure {
            let programs = try! json.getArray(at: "ProgramList", "Programs").map(Program.init)
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
}
