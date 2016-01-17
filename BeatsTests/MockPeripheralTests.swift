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
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCanDiscoverServices() {
        mockPeripheral.discoverServices(nil)
        XCTAssertTrue(mockPeripheral.didDiscoverServicesCalled)
    }
    

}


