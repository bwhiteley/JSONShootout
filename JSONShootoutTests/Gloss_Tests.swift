//
//  Gloss_Tests.swift
//  JSONShootout
//
//  Created by Ehsan Rezaie on 10/27/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import XCTest
import ModelObjects
import Gloss

class Gloss_Tests: XCTestCase {

    func testPerformance() {
        
        let dict: [String: Any] = try! JSONSerialization.jsonObject(with: self.data, options: []) as! [String: Any]
        
        self.measure {

            let programs: [Program] = "ProgramList.Programs" <~~ dict ?? []
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()

}
