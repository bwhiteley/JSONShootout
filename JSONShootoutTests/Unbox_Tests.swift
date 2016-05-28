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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformance() {
        //let json = try! JSONParser.JSONObjectWithData(data)

        self.measureBlock {
            let programs:[Program] = try! Unboxer.performCustomUnboxingWithData(self.data) { unboxer in
                let programs:[Program] = unboxer.unbox("ProgramList.Programs", isKeyPath:true)
                return programs
            }
            XCTAssert(programs.count > 1000)
            
            //let programs:[Program] = try! json.valueForKey("ProgramList.Programs")
        }
    }
    
    private lazy var data:NSData = {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Large", ofType: "json")
        let data = NSData(contentsOfFile: path!)!
        return data
    }()

}
