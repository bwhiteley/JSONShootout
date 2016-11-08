//
//  PMJSON_Tests.swift
//  JSONShootout
//
//  Created by Kevin Ballard on 11/4/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import PMJSON

class PMJSON_Tests: XCTestCase {
    
    func testDeserialization() {
        self.measure {
            do {
                let json = try JSON.decode(self.data)
                
                XCTAssert(json.object?.count ?? 0 > 0)
            } catch {
                XCTFail("Failed to parse: \(error)")
            }
        }
    }
    
    func testPerformance() {
        do {
            let json = try JSON.decode(data)
            
            self.measure {
                do {
                    let programs = try json.getObject("ProgramList", { try $0.mapArray("Programs", Program.init(pmjson:)) })
                    XCTAssert(programs.count > 1000)
                } catch {
                    XCTFail("Mapping did fail: \(error)")
                }
            }
        } catch {
            XCTFail("Failed to parse: \(error)")
        }
    }
    
    private lazy var data: Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        return data
    }()
}
