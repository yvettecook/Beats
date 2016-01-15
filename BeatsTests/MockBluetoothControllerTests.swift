//
//  MockBluetoothControllerTests.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class MockBluetoothControllerTests: XCTestCase {
    
    var mockBluetoothController: MockBluetoothController!
    
    let blankCompletionHandler = { (_: Bool) -> Void in }

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
        mockBluetoothController.scanForAvailableMonitors(blankCompletionHandler)
        let state = mockBluetoothController.state
        
        XCTAssertEqual(state, BluetoothControllerState.Scanning) 
    }
    
    func testOnScanForAvailableMonitorsCentralManagerScanMethodCalled() {
        mockBluetoothController.scanForAvailableMonitors(blankCompletionHandler)
        XCTAssertTrue(mockBluetoothController!.centralManager!.scanForPeripheralsWithServicesCalled)
    }
    
    func testOnScanForAvailableMonitorsPeripheralIsFound() {
        let expectation = expectationWithDescription("didDiscoverPeripheral should be called")
        
        let completionHandler = { (success: Bool) -> Void in
            XCTAssertTrue(self.mockBluetoothController.didDiscoverPeripheralCalled)
            expectation.fulfill()
        }
    
        mockBluetoothController.scanForAvailableMonitors(completionHandler)
        
        waitForExpectationsWithTimeout(4.0, handler: nil)
    }
}
