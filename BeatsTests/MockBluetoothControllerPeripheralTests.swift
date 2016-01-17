//
//  MockBluetoothControllerPeripheralTests.swift
//  Beats
//
//  Created by Yvette Cook on 17/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
@testable import Beats

class MockBluetoothControllerPeripheralTests: XCTestCase {
    
    var mockBluetoothController: MockBluetoothController!
    let mockPeripheral = MockPeripheral()
    
    override func setUp() {
        mockBluetoothController = MockBluetoothController()
        mockBluetoothController.centralManager = MockCentralManager(delegate: mockBluetoothController, queue:  nil)
        mockBluetoothController.centralManager(self.mockBluetoothController.centralManager!, didConnectPeripheral: mockPeripheral)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStateIsConnected() {
        let state = mockBluetoothController.state
        XCTAssertEqual(state, BluetoothControllerState.ConnectedMonitor)
    }
    
    func testCanBePeripheralsDelegate() {
        let delegate = mockPeripheral.delegate as! MockBluetoothController
        XCTAssertEqual(delegate, mockBluetoothController)
    }
    
    func testOnConnectionDidDiscoverServices() {
        XCTAssertTrue(mockBluetoothController.didDiscoverServicesCalled)
    }
    
}
