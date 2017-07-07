//
//  Decodable_Tests.swift
//  JSONShootoutTests
//
//  Created by Bart Whiteley on 6/16/17.
//  Copyright © 2017 SwiftBit. All rights reserved.
//


import XCTest
import ModelObjects
import Marshal

class Decodable_Tests: XCTestCase {
    
    
    func testDeserializationOnly() {
        self.measure {
            let json = try! JSONParser.JSONObjectWithData(self.data as Data)
            XCTAssert(json.count > 0)
        }
    }
    
    
    func testSwiftDecoderPerformance() throws {
        let decoder = JSONDecoder()
        let data = self.data
        self.measure {
            let container: Container = try! decoder.decode(Container.self, from: data)
            XCTAssert(container.programList.programs.count > 1000)
        }
    }
    
    func testMarshalPerformance() {
        let data = self.data
        self.measure {
            let json = try! JSONParser.JSONObjectWithData(data)
            let programs:[Program] = try! json.value(for:"ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    func testMarshalPerformance_MappingOnly() {
        let json = try! JSONParser.JSONObjectWithData(self.data as Data)
        self.measure {
            let programs:[Program] = try! json.value(for:"ProgramList.Programs")
            XCTAssert(programs.count > 1000)
        }
    }
    
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
}

struct Container: Decodable {
    let programList: ProgramList
    
    enum CodingKeys: String, CodingKey {
        case programList = "ProgramList"
    }
}

struct ProgramList: Decodable {
    let programs: [Program]
    
    enum CodingKeys: String, CodingKey {
        case programs = "Programs"
    }
}

