//
//  MockCentralManagerTests.swift
//  Beats
//
//  Created by Yvette Cook on 10/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
import CoreBluetooth

@testable import Beats

class MockCentralManagerTests: XCTestCase {
    
    var mockCentralManager: MockCentralManager!
    let mockPeripheral = MockPeripheral()
    
    let heartRateUUID = CBUUID(string: "180D")
    var heartRateService : CBMutableService?
    
    override func setUp() {
        mockCentralManager = MockCentralManager(delegate: MockBluetoothController(), queue: nil)
        heartRateService = CBMutableService(type: heartRateUUID, primary: true)
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
        weak var expectation = expectationWithDescription("Should find Peripheral when scanning")
        
        mockCentralManager.scanForPeripheralsWithServices(nil, options: nil)
        
        let completion = { () -> Void in
            XCTAssertTrue(self.mockCentralManager.discoveredPeripheral)
            expectation?.fulfill()
        }
        
        asyncTest(completion, wait: 2)
        
        waitForExpectationsWithTimeout(3, handler: nil)
    }
    
    func testCanConnectToPeripheral() {
        mockCentralManager.connectPeripheral(mockPeripheral, options: nil)
        
        XCTAssertTrue(self.mockCentralManager.connectedToPeripheral)
    }

}
