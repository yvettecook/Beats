//
//  MockPeripheralTests.swift
//  Beats
//
//  Created by Yvette Cook on 11/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
import CoreBluetooth

@testable import Beats

class MockPeripheralTests: XCTestCase {
    
    var mockPeripheral: MockPeripheral!
    
    override func setUp() {
        mockPeripheral = MockPeripheral()
        mockPeripheral.delegate = MockBluetoothController()
        mockPeripheral.discoverServices(nil)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCanDiscoverServices() {
        XCTAssertTrue(mockPeripheral.didDiscoverServicesCalled)
    }
    
    func testHasHeartRateServiceCBUUID() {
        XCTAssertNotNil(mockPeripheral.services)
    }
    
    func testCanReturnHRService() {
        let result = mockPeripheral.getHeartRateService()
        XCTAssertNotNil(result)
    }
    
    func testCanReturnHRMeasurementCharacteristic() {
        let result = mockPeripheral.getHeartRateMeasurementCharacteristic()
        XCTAssertNotNil(result)
    }
    
    func testCanChangeNotifyValueForCharacteristic() {
        let char = mockPeripheral.getHeartRateMeasurementCharacteristic()
        mockPeripheral.setNotifyValue(true, forCharacteristic: char!)
        XCTAssertTrue(mockPeripheral.notifyOnHRUpdate)
    }
    
    func testCanSetHeartRateMode() {
        mockPeripheral.setHeartRateMode(.SteadyResting)
        XCTAssertNotNil(mockPeripheral.availableHRs)
    }

    func testCanStartPulse() {
        weak var expectation = expectationWithDescription("Pulse should start")
        
        let completion = { () -> Void in
            XCTAssertTrue(self.mockPeripheral.updateHRCalled)
            expectation?.fulfill()
        }
        
        mockPeripheral.setHeartRateMode(.SteadyResting)
        asyncTest(completion, wait: 1)
        
        waitForExpectationsWithTimeout(1.5, handler: nil)
    }
    
    func testIfNotifyOnHRSetWillUpdateDelegate() {
        weak var expectation = expectationWithDescription("Delegate should be updated")
        
        let completion = { () -> Void in
            let btc = self.mockPeripheral.delegate as! MockBluetoothController
            XCTAssertTrue(btc.hrNotificationReceived)
            expectation?.fulfill()
        }
        
        mockPeripheral.setHeartRateMode(.SteadyResting)
        asyncTest(completion, wait: 1)
        
        waitForExpectationsWithTimeout(1.5, handler: nil)
    }
    
}


