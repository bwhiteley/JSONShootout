//
//  ObjectMapper_Test.swift
//  JSONShootout
//
//  Created by Denis Bogomolov on 25/10/2016.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ObjectMapper
import ModelObjects

class ObjectMapper_Test: XCTestCase {
    struct ProgramList: ImmutableMappable {
        let programs: [Program]
        init(map: Map) throws {
            programs = try map.value("ProgramList.Programs")
        }
        func mapping(map: Map) {
            programs >>> map["ProgramList.Programs"]
        }
    }
    
    func testPerformance() {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
        self.measure {
            let list: ProgramList = try! ProgramList(JSON: json)
            XCTAssert(list.programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        return data
    }()
}
