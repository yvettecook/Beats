//
//  MockCentralManagerTests.swift
//  Beats
//
//  Created by Yvette Cook on 10/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class MockCentralManagerTests: XCTestCase {
    
    var mockCentralManager: MockCentralManager!

    override func setUp() {
        mockCentralManager = MockCentralManager(delegate: MockBluetoothController(), queue: nil)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasDelegate() {
        XCTAssertNotNil(mockCentralManager.delegate)
    }
    
    func testRespondsToScanForPeripheralsWithServices() {
        mockCentralManager.scanForPeripheralsWithServices(nil, options: nil)
    }



}
