//
//  SessionTests.swift
//  Beats
//
//  Created by Yvette Cook on 02/02/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
@testable import Beats

class SessionTests: XCTestCase {
    
    var session: Session!

    override func setUp() {
        session = Session()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasAStartTime() {
        XCTAssertNotNil(session.startTime)
    }
    
    func testHasEndTime() {
        session.end()
        XCTAssertNotNil(session.endTime)
    }
    
    func testCanGiveName() {
        session.name("Test")
        XCTAssertEqual(session.name, "Test")
    }

    func testCanAddValue() {
        session.addValue(1)
        XCTAssertEqual(session.values![0].value, 1)
    }
    
    
}
