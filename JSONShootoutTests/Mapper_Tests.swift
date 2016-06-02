//
//  Mapper_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import XCTest
import ModelObjects
import Mapper

class Mapper_Tests: XCTestCase {

    func testDeserialization() {
        self.measureBlock {
            let d:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(self.data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }
    
    func testPerformance() {
        
        let dict = try! NSJSONSerialization.JSONObjectWithData(self.data, options: []) as! NSDictionary
        let mapper = Mapper(JSON: dict)
        
        self.measureBlock {
            let programs:[Program] = try! mapper.from("ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:NSData = {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Large", ofType: "json")
        let data = NSData(contentsOfFile: path!)!
        return data
    }()

}
