//
//  Marshal_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import XCTest
import ModelObjects
import Decodable

class Decodable_Tests: XCTestCase {

    func testDeserialization() {
        self.measure {
            let d:NSDictionary = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }
    
    func testPerformance() {
        let dict = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
        
        self.measure {
            let programs:[Program] = try! dict => "ProgramList" => "Programs"
            XCTAssert(programs.count > 1000)
        }
    }
    
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()

}
