//
//  MockBluetoothControllerConnectionTests.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class MockBluetoothControllerConnectionTests: XCTestCase {
    
    var mockBluetoothController: MockBluetoothController!
    let mockPeripheral = MockPeripheral()

    override func setUp() {
        mockBluetoothController = MockBluetoothController()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCanInitializeWithCentralManager() {
        XCTAssertNotNil(mockBluetoothController.centralManager)
    }
    
    func testHasState() {
        XCTAssertEqual(mockBluetoothController.state, BluetoothControllerState.StartedUp)
    }
    
    func testScanForAvailableMonitorsChangesState() {
        mockBluetoothController.scanForAvailableMonitors()
        let state = mockBluetoothController.state
        
        XCTAssertEqual(state, BluetoothControllerState.Scanning) 
    }
    
    func testOnScanForAvailableMonitorsCentralManagerScanMethodCalled() {
        mockBluetoothController.scanForAvailableMonitors()
        XCTAssertTrue(mockBluetoothController!.centralManager!.scanForPeripheralsWithServicesCalled)
    }
    
    func testOnScanForAvailableMonitorsPeripheralIsFound() {
        weak var expectation = expectationWithDescription("didDiscoverPeripheral should be called")
        
        let completion = { () -> Void in
            XCTAssertTrue(self.mockBluetoothController.didDiscoverPeripheralCalled)
            expectation?.fulfill()
        }
    
        mockBluetoothController.scanForAvailableMonitors()
        
        asyncTest(completion, wait: 3)
        
        waitForExpectationsWithTimeout(3.5, handler: nil)
    }
    
    func testWhenPeripheralFoundConnected() {
        weak var expectation = expectationWithDescription("Should connect to peripheral when found")
        
        let completion = { () -> Void in
            XCTAssertTrue(self.mockBluetoothController.didConnectPeripheralCalled)
            expectation?.fulfill()
        }
        
        mockBluetoothController.scanForAvailableMonitors()
        
        asyncTest(completion, wait: 4)
        
        waitForExpectationsWithTimeout(4.5, handler: nil)
    }
    
    func testStateChangeToConnected() {
        mockBluetoothController.centralManager(self.mockBluetoothController.centralManager!, didConnectPeripheral: mockPeripheral)
        
        let state = self.mockBluetoothController.state
        
        XCTAssertEqual(state, BluetoothControllerState.ConnectedMonitor)
    }
    
}
