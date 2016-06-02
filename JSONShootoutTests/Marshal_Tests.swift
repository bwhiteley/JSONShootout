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
        self.measureBlock {
            let d:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(self.data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }
    
    func testTypedDeserialization() {
        self.measureBlock {
            let json = try! JSONParser.JSONObjectWithData(self.data)
            XCTAssert(json.count > 0)
        }
    }
    
    func testDictionaryPerformance() {
        let json = try! JSONParser.JSONObjectWithData(data)
        
        self.measureBlock {
            let programs:[Program] = try! json.valueForKey("ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    func testNSDictionaryPerformance() {
        let json = try! NSJSONSerialization.JSONObjectWithData(self.data, options: []) as! NSDictionary
        
        self.measureBlock {
            let programs:[Program] = try! json.valueForKey("ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:NSData = {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Large", ofType: "json")
        let data = NSData(contentsOfFile: path!)!
        return data
    }()

}
