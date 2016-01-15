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
        XCTAssertTrue(mockCentralManager.scanForPeripheralsWithServicesCalled)
    }

    func testFindsPeripheralOnScanForPeripherals() {        
        mockCentralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            XCTAssertTrue(self.mockCentralManager.discoveredPeripheral)
        }
    }
    
    
    
}
