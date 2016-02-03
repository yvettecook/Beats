//
//  MockBluetoothControllerPeripheralTests.swift
//  Beats
//
//  Created by Yvette Cook on 17/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

/* weak var used for expectations to avoid crash if expectation is fulfilled after wait period

    http://stackoverflow.com/questions/27555499/xctestexpectation-how-to-avoid-calling-the-fulfill-method-after-the-wait-contex
*/

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
    
    func testIfPeripheralHasHeartRateServiceDiscoverCharacteristics() {
        XCTAssertTrue(mockBluetoothController.didDiscoverCharacteristicsCalled)
    }
    
    func testReceivesUpdatesOnHeartRate() {
        weak var expectation = expectationWithDescription("Should see a pulse")
        
        let completion = { () -> Void in
            XCTAssertTrue(self.mockBluetoothController.hrNotificationReceived)
            expectation?.fulfill()
        }
        
        mockPeripheral.setHeartRateMode(.SteadyResting)
        asyncTest(completion, wait: 4)
        
        waitForExpectationsWithTimeout(6.5, handler: nil)
    }
    
}
