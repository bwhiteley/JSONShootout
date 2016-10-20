//
//  Unbox_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import XCTest
import Unbox
import ModelObjects

class Unbox_Tests: XCTestCase {

    func testPerformance() {
        
        let dict = try! JSONSerialization.jsonObject(with: self.data, options: [])
        
        self.measure {
            let programs:[Program] = try! Unboxer.performCustomUnboxing(dictionary: dict as! UnboxableDictionary) { unboxer in
                let programs:[Program] = try! unboxer.unbox(keyPath:"ProgramList.Programs")
                return programs
            }
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()

}
