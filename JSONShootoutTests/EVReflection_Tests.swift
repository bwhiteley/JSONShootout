//
//  EVReflection_Tests.swift
//  JSONShootout
//
//  Created by Edwin Vermeer on 26/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import EVReflection

class EVReflection_Tests: XCTestCase {
    
    func testDeserialization() {
        self.measure {
            let d:NSDictionary = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }
    
    func testPerformance() {
        EVReflection.setBundleIdentifier(ProgramObject.self)
        self.measure {
            let programs = [ProgramObject](data: self.data, forKeyPath: "ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
}
