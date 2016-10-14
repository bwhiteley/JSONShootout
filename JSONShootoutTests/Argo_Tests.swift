//
//  Argo_Tests.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 10/14/16.
//  Copyright © 2016 SwiftBit. All rights reserved.
//

import XCTest
import ModelObjects
import Argo
import Curry
import Runes

class Argo_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformance() {
        
        let json: Any! = try! JSONSerialization.jsonObject(with: data, options: [])
        
//        var d = json as! [String: Any]
//        d = d["ProgramList"] as! [String : Any]
//        
//        let ra:[[String: Any]] = d["Programs"] as! [[String : Any]]
//        
//        for json in ra {
//            guard let program:Program = decode(json) else {
//                let r:[String:Any] = json["Recording"] as! [String:Any]
//                let g:String = r["RecGroup"] as! String
//                print(g)
//                continue
//            }
//        }
//        
        
        self.measure {
            let programList:ProgramList = decode(json)!
            XCTAssert(programList.programs.count > 1000)
        }
    }
    
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()

}

struct ProgramList {
    var programs:[Program]
}

extension ProgramList: Decodable {
    static func decode(_ json: JSON) -> Decoded<ProgramList> {
        return curry(ProgramList.init)
        <^> json <|| ["ProgramList", "Programs"]
    }
}


