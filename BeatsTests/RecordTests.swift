//
//  RecordTests.swift
//  Beats
//
//  Created by Yvette Cook on 03/02/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
@testable import Beats

class RecordTests: XCTestCase {
    
    var record: Record!

    override func setUp() {
        record = Record(value: 1)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasTime() {
        XCTAssertNotNil(record.time)
    }

}
