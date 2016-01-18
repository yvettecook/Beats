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

    func testCanUpdateHeartRateValueForCharacteristic() {
        
    }
    
}


